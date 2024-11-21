require "yaml"
require "colorize"

class Linquebot::App::Config
  include YAML::Serializable

  CONFIG_FILE_PATH = "./config.yaml"
  
  @[YAML::Field(key: "bot_token")]
  getter bot_token : String

  class BrokenYAMLFileError < Exception
  end

  def self.read_from_file
    begin
      File.open(CONFIG_FILE_PATH) { |f| self.from_yaml(f) }
    rescue err : YAML::ParseException
      raise BrokenYAMLFileError.new("#{CONFIG_FILE_PATH} is not a valid YAML file: #{err.message}")
    end
  end

  def initialize(token = "")
    @bot_token = token
  end

  def self.create_from_stdin
    print "What's your Telegram bot token? "
    bot_token = gets.as(String)
    print "What is the bot's username? (Used to confirm that you are xxx_bot in /command@xxx_bot) "
    bot_name = gets.as(String)
    
    Config.new(bot_token).save!
  end

  def save!
    File.open(CONFIG_FILE_PATH, "w") do |file|
      file.print self.to_yaml
    end
    puts "Configuration file saved to #{CONFIG_FILE_PATH}".colorize(:green)
    self
  end

  def pretty_print
    puts <<-EOF
      Config<bot_token: "#{bot_token}">
      EOF
    self
  end
end