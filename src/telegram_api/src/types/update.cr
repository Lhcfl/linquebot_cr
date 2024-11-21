require "json"
require "./message"

module TelegramApi::Types
  class Update
    include JSON::Serializable
    include JSON::Serializable::Unmapped

    # The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially. This identifier becomes especially handy if you're using webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.
    getter update_id : Int64

    # Optional. New incoming message of any kind - text, photo, sticker, etc.
    getter message : Message?

    # Optional. New version of a message that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
    getter edited_message : Message?

    # Optional. New incoming channel post of any kind - text, photo, sticker, etc.
    getter channel_post : Message?

    # Optional. New version of a channel post that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
    getter edited_channel_post : Message?

    # # Optional. The bot was connected to or disconnected from a business account, or a user edited an existing connection with the bot
    # getter business_connection : BusinessConnection?

    # # Optional. New message from a connected business account
    # getter business_message : Message?

    # # Optional. New version of a message from a connected business account
    # getter edited_business_message : Message?

    # # Optional. Messages were deleted from a connected business account
    # getter deleted_business_messages : BusinessMessagesDeleted?

    # # Optional. A reaction to a message was changed by a user. The bot must be an administrator in the chat and must explicitly specify "message_reaction" in the list of allowed_updates to receive these updates. The update isn't received for reactions set by bots.
    # getter message_reaction : MessageReactionUpdated?

    # # Optional. Reactions to a message with anonymous reactions were changed. The bot must be an administrator in the chat and must explicitly specify "message_reaction_count" in the list of allowed_updates to receive these updates. The updates are grouped and can be sent with delay up to a few minutes.
    # getter message_reaction_count : MessageReactionCountUpdated?

    # # Optional. New incoming inline query
    # getter inline_query : InlineQuery?

    # # Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.
    # getter chosen_inline_result : ChosenInlineResult?

    # # Optional. New incoming callback query
    # getter callback_query : CallbackQuery?

    # # Optional. New incoming shipping query. Only for invoices with flexible price
    # getter shipping_query : ShippingQuery?

    # # Optional. New incoming pre-checkout query. Contains full information about checkout
    # getter pre_checkout_query : PreCheckoutQuery?

    # # Optional. A user purchased paid media with a non-empty payload sent by the bot in a non-channel chat
    # getter purchased_paid_media : PaidMediaPurchased?

    # # Optional. New poll state. Bots receive only updates about manually stopped polls and polls, which are sent by the bot
    # getter poll : Poll?

    # # Optional. A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.
    # getter poll_answer : PollAnswer?

    # # Optional. The bot's chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.
    # getter my_chat_member : ChatMemberUpdated?

    # # Optional. A chat member's status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify "chat_member" in the list of allowed_updates to receive these updates.
    # getter chat_member : ChatMemberUpdated?

    # # Optional. A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.    
    # getter chat_join_request : ChatJoinRequest?

    # # Optional. A chat boost was added or changed. The bot must be an administrator in the chat to receive these updates.
    # getter chat_boost : ChatBoostUpdated?

    # # Optional. A boost was removed from a chat. The bot must be an administrator in the chat to receive these updates.
    # getter removed_chat_boost : ChatBoostRemoved?
  end
end