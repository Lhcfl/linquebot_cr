require "event_handler"
require "yaml"
require "colorize"

class Linquebot::App
end
require "./lib/*"
require "./telegram_api/src/telegram_api"

class Linquebot::App
  SLEEP_DURATION_WHEN_FAILED = 2.seconds
  POLLING_TIMEOUT = 20

  class AppEvents
    include EventHandler
    
    event Message, message : TelegramApi::Types::Message
    event TextMessage, message : TelegramApi::Types::Message, text : String
  end

  getter api_client : TelegramApi::ApiClient
  getter config : Config
  getter bot_profile : TelegramApi::Types::User
  getter events = AppEvents.new

  @next_offset : Int64 = 0

  class AppInitializeError < Exception
    class BrokenConfig < AppInitializeError
    end
    class BotUserNotFound < AppInitializeError
    end
  end

  private def get_config
    begin
      Linquebot::Logger.debug.print "Reading config from file... "

      Config.read_from_file
    rescue File::NotFoundError
      Linquebot::Logger.debug.puts "failed".colorize(:red)
      Linquebot::Logger.debug.puts "Config file #{Config::CONFIG_FILE_PATH} not found."
      
      Config.create_from_stdin
    rescue e : Config::BrokenYAMLFileError
      Linquebot::Logger.debug.puts "failed".colorize(:red)

      raise AppInitializeError::BrokenConfig.new <<-EOF
      Broken YAML file detected: #{e.message}
      
      Please consider repairing or rebuilding the config file.
      EOF
    end
  end

  def greeting
    puts <<-EOF
    Hello Linquebot Crystal #{Linquebot::VERSION}
    ==================
    EOF
  end

  def initialize
    greeting

    @config = get_config.pretty_print
    @api_client = TelegramApi::ApiClient.new(config.bot_token)

    if api_client.use_proxy?
      puts "Using proxy: #{ENV["https_proxy"]?}"
    end
    
    @bot_profile = begin
      puts "Getting Bot Profile... "
      api_client.getMe!
    rescue err : TelegramApi::TelegramApiError
      puts "failed".colorize(:red)
      if err.code == TelegramApi::TelegramApiError::CODE_NOT_FOUND
        raise AppInitializeError::BotUserNotFound.new <<-EOF
        Got response: #{err.body}

        Can't find the bot user, maybe you entered a wrong token?
        EOF
      end

      raise AppInitializeError.new(err.message)
    end

    Linquebot::Logger.debug.puts @bot_profile.to_json
    puts "Bot initialized successfully".colorize(:green)
  end

  def poll_once
    Linquebot::Logger.debug.print "[Poll] polling... "
    updates = api_client.getUpdates!({
      offset: @next_offset,
      timeout: POLLING_TIMEOUT,
    })
    Linquebot::Logger.debug.print "success".colorize(:green), " got #{updates.size} updates\n"

    updates.each do |update|
      Linquebot::Logger.debug.print "[APP] Received Update ", update.to_json, "\n"

      if message = update.message
        events.emit AppEvents::Message, message
        if text = message.text
          events.emit AppEvents::TextMessage, message, text
        end
      end

      @next_offset = { @next_offset, update.update_id + 1 }.max
    end

    Linquebot::Logger.debug.puts "[Poll] Next Offset: #{@next_offset}"
  end

  def start_polling
    loop do
      begin
        poll_once
      rescue err : Exception
        STDERR.puts "[Unhandled Error] #{err.inspect_with_backtrace}"
        sleep SLEEP_DURATION_WHEN_FAILED
      end
    end
  end

end

module Linquebot
  def self.app
    @@app ||= Linquebot::App.new
  end
end