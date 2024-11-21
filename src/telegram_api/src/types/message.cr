require "json"
require "./chat"
require "./user"

module TelegramApi::Types
  class Message
    include JSON::Serializable
    include JSON::Serializable::Unmapped

    # Unique message identifier inside this chat. In specific instances (e.g., message containing a video sent to a big chat), the server might automatically schedule a message instead of sending it immediately. In such cases, this field will be 0 and the relevant message will be unusable until it is actually sent
    getter message_id : Int64

    # Optional. Unique identifier of a message thread to which the message belongs; for supergroups only
    getter message_thread_id : Int64?

    # Optional. Sender of the message; may be empty for messages sent to channels. For backward compatibility, if the message was sent on behalf of a chat, the field contains a fake sender user in non-channel chats
    getter from : User?

    # Optional. Sender of the message when sent on behalf of a chat. For example, the supergroup itself for messages sent by its anonymous administrators or a linked channel for messages automatically forwarded to the channel's discussion group. For backward compatibility, if the message was sent on behalf of a chat, the field from contains a fake sender user in non-channel chats.
    getter sender_chat : Chat?

    # Optional. If the sender of the message boosted the chat, the number of boosts added by the user
    getter sender_boost_count : Int64?

    # Optional. The bot that actually sent the message on behalf of the business account. Available only for outgoing messages sent on behalf of the connected business account.
    getter sender_business_bot : User?

    # Date the message was sent in Unix time. It is always a positive number, representing a valid date.
    getter date : Int64

    # Optional. Unique identifier of the business connection from which the message was received. If non-empty, the message belongs to a chat of the corresponding business account that is independent from any potential bot chat which might share the same identifier.
    getter business_connection_id : String?

    # Chat the message belongs to
    getter chat : Chat

    # Optional. For replies in the same chat and message thread, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
    getter reply_to_message : Message?

    # Optional. Information about the original message for forwarded messages
    # getter forward_origin : MessageOrigin?

    # # Optional. Bool, if the message is sent to a forum topic
    # getter is_topic_message : Bool?

    # # Optional. Bool, if the message is a channel post that was automatically forwarded to the connected discussion group
    # getter is_automatic_forward : Bool?

    # # Optional. Information about the message that is being replied to, which may come from another chat or forum topic
    # getter external_reply : ExternalReplyInfo?

    # # Optional. For replies that quote part of the original message, the quoted part of the message
    # getter quote : TextQuote?

    # # Optional. For replies to a story, the original story
    # getter reply_to_story : Story?

    # Optional. Bot through which the message was sent
    getter via_bot : User?

    # Optional. Date the message was last edited in Unix time
    getter edit_date : Int64?

    # Optional. Bool, if the message can't be forwarded
    getter has_protected_content : Bool?

    # Optional. Bool, if the message was sent by an implicit action, for example, as an away or a greeting business message, or as a scheduled message
    getter is_from_offline : Bool?

    # Optional. The unique identifier of a media message group this message belongs to
    getter media_group_id : String?

    # Optional. Signature of the post author for messages in channels, or the custom title of an anonymous group administrator
    getter author_signature : String?

    # Optional. For text messages, the actual UTF-8 text of the message
    getter text : String?

    # # Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
    # getter entities : MessageEntity[]?	

    # # Optional. Options used for link preview generation for the message, if it is a text message and link preview options were changed
    # getter link_preview_options : LinkPreviewOptions?

    # # Optional. Unique identifier of the message effect added to the message
    # getter effect_id : String?

    # # Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set
    # getter animation : Animation?

    # # Optional. Message is an audio file, information about the file
    # getter audio : Audio?

    # # Optional. Message is a general file, information about the file
    # getter document : Document?

    # # Optional. Message contains paid media; information about the paid media
    # getter paid_media : PaidMediaInfo?

    # # Optional. Message is a photo, available sizes of the photo
    # getter photo	: PhotoSize[]?

    # # Optional. Message is a sticker, information about the sticker
    # getter sticker : Sticker?

    # # Optional. Message is a forwarded story
    # getter story : Story?

    # # Optional. Message is a video, information about the video
    # getter video : Video?

    # # Optional. Message is a video note, information about the video message
    # getter video_note : VideoNote?

    # # Optional. Message is a voice message, information about the file
    # getter voice : Voice?

    # # Optional. Caption for the animation, audio, document, paid media, photo, video or voice
    # getter caption : String?

    # # Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption
    # getter caption_entities	MessageEntity[]?

    # # Optional. Bool, if the caption must be shown above the message media
    # getter show_caption_above_media : Bool?

    # # Optional. Bool, if the message media is covered by a spoiler animation
    # getter has_media_spoiler : Bool?

    # # Optional. Message is a shared contact, information about the contact
    # getter contact : Contact?

    # # Optional. Message is a dice with random value
    # getter dice : Dice?

    # # Optional. Message is a game, information about the game. More about games »
    # getter game : Game?

    # # Optional. Message is a native poll, information about the poll
    # getter poll : Poll?

    # # Optional. Message is a venue, information about the venue. For backward compatibility, when this field is set, the location field will also be set
    # getter venue : Venue?

    # # Optional. Message is a shared location, information about the location
    # getter location : Location?

    # # Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)
    # getter new_chat_members : User[]?

    # # Optional. A member was removed from the group, information about them (this member may be the bot itself)
    # getter left_chat_member : User?

    # # Optional. A chat title was changed to this value
    # getter new_chat_title : String?

    # # Optional. A chat photo was change to this value
    # getter new_chat_photo PhotoSize[]

    # # Optional. Service message: the chat photo was deleted
    # getter delete_chat_photo : Bool?

    # # Optional. Service message: the group has been created
    # getter group_chat_created : Bool?

    # # Optional. Service message: the supergroup has been created. This field can't be received in a message coming through updates, because bot can't be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
    # getter supergroup_chat_created : Bool?

    # # Optional. Service message: the channel has been created. This field can't be received in a message coming through updates, because bot can't be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
    # getter channel_chat_created : Bool?

    # # Optional. Service message: auto-delete timer settings changed in the chat
    # getter message_auto_delete_timer_changed : MessageAutoDeleteTimerChanged?

    # # Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit Int64 or double-precision float type are safe for storing this identifier.
    # getter migrate_to_chat_id : Int64?

    # # Optional. The supergroup has been migrated from a group with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit Int64 or double-precision float type are safe for storing this identifier.
    # getter migrate_from_chat_id : Int64?

    # # Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
    # getter pinned_message : MaybeInaccessibleMessage?

    # # Optional. Message is an invoice for a payment, information about the invoice. More about payments »
    # getter invoice : Invoice?

    # # Optional. Message is a service message about a successful payment, information about the payment. More about payments »
    # getter successful_payment : SuccessfulPayment?

    # # Optional. Message is a service message about a refunded payment, information about the payment. More about payments »
    # getter refunded_payment : RefundedPayment?

    # # Optional. Service message: users were shared with the bot
    # getter users_shared : UsersShared?

    # # Optional. Service message: a chat was shared with the bot
    # getter chat_shared : ChatShared?

    # # Optional. The domain name of the website on which the user has logged in. More about Telegram Login »
    # getter connected_website : String?

    # # Optional. Service message: the user allowed the bot to write messages after adding it to the attachment or side menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess
    # getter write_access_allowed : WriteAccessAllowed?

    # # Optional. Telegram Passport data
    # getter passport_data : PassportData?

    # # Optional. Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.
    # getter proximity_alert_triggered : ProximityAlertTriggered?

    # # Optional. Service message: user boosted the chat
    # getter boost_added : ChatBoostAdded?

    # # Optional. Service message: chat background set
    # getter chat_background_set : ChatBackground?

    # # Optional. Service message: forum topic created
    # getter forum_topic_created : ForumTopicCreated?

    # # Optional. Service message: forum topic edited
    # getter forum_topic_edited : ForumTopicEdited?

    # # Optional. Service message: forum topic closed
    # getter forum_topic_closed : ForumTopicClosed?

    # # Optional. Service message: forum topic reopened
    # getter forum_topic_reopened : ForumTopicReopened?

    # # Optional. Service message: the 'General' forum topic hidden
    # getter general_forum_topic_hidden : GeneralForumTopicHidden?

    # # Optional. Service message: the 'General' forum topic unhidden
    # getter general_forum_topic_unhidden : GeneralForumTopicUnhidden?

    # # Optional. Service message: a scheduled giveaway was created
    # getter giveaway_created : GiveawayCreated?

    # # Optional. The message is a scheduled giveaway message
    # getter giveaway : Giveaway?

    # # Optional. A giveaway with public winners was completed
    # getter giveaway_winners : GiveawayWinners?

    # # Optional. Service message: a giveaway without public winners was completed
    # getter giveaway_completed : GiveawayCompleted?

    # # Optional. Service message: video chat scheduled
    # getter video_chat_scheduled : VideoChatScheduled?

    # # Optional. Service message: video chat started
    # getter video_chat_started : VideoChatStarted?

    # # Optional. Service message: video chat ended
    # getter video_chat_ended : VideoChatEnded?

    # # Optional. Service message: new participants invited to a video chat
    # getter video_chat_participants_invited : VideoChatParticipantsInvited?

    # # Optional. Service message: data sent by a Web App
    # getter web_app_data : WebAppData?

    # # Optional. Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.
    # getter reply_markup : InlineKeyboardMarkup?
  end
  # class Message < NonReplyMessage
  #   include JSON::Serializable
  #   include JSON::Serializable::Unmapped
  #   # Optional. For replies in the same chat and message thread, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
  #   getter reply_to_message : Message?
  # end
end


