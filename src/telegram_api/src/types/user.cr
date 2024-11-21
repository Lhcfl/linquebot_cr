require "json"

class TelegramApi::Types::User
  include JSON::Serializable
  include JSON::Serializable::Unmapped

  getter id : Int64
  getter is_bot : Bool
  getter first_name : String
  getter last_name : String?
  getter username : String?
  getter language_code : String?
  getter is_premium : Bool?
  getter added_to_attachment_menu : Bool?
  getter can_join_groups : Bool?
  getter can_read_all_group_messages : Bool?
  getter supports_inline_queries : Bool?
  getter can_connect_to_business : Bool?
  getter has_main_web_app : Bool?
end
