module Linquebot::Plugin::Rong
  include Linquebot::Lib
  
  extend self

  def get_html_username(user : TelegramApi::Types::User)
    name = user.first_name
    name += " #{user.last_name}" if user.last_name

    <<-HTML
    <a href="tg://user?id=#{user.id}">#{escape_html name}</a>
    HTML
  end

  Linquebot.app.events.on Linquebot::App::AppEvents::TextMessage do | ev |
    message = ev.message
    text = ev.text
    next unless actor = message.from
    next unless chat = message.chat
    next unless replied = message.reply_to_message
    next unless actee = replied.from

    case text[0]
    when '/' then nil
    when '\\' then actor, actee = actee, actor
    else next
    end

    action, other = text[1..].split(2).concat([""])
    html_actor_name = get_html_username actor
    html_actee_name = get_html_username actee

    html_actee_name = "自己" if actor.id == actee.id

    Linquebot.app.api_client.sendMessage!({
      chat_id: chat.id,
      text: "#{html_actor_name} #{escape_html action} #{html_actee_name} #{escape_html other}!",
      parse_mode: "HTML",
    })
  end
end

puts "[PLUGIN LOADED] rong"

