require "json"

class TelegramApi::Types::Chat
  include JSON::Serializable
  include JSON::Serializable::Unmapped

  # Unique identifier for this chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.   
  getter id : Int64

  # Type of the chat, can be either “private”, “group”, “supergroup” or “channel”
  getter type : String

  # Optional. Title, for supergroups, channels and group chats
  getter title : String?

  # Optional. Username, for private chats, supergroups and channels if available
  getter username : String?

  # Optional. First name of the other party in a private chat
  getter first_name : String?

  # Optional. Last name of the other party in a private chat
  getter last_name : String?

  # Optional. True, if the supergroup chat is a forum (has topics enabled)
  getter is_forum : Bool?
end