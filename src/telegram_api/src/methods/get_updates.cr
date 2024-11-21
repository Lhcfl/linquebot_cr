class TelegramApi::ApiClient
  define_method :getUpdates, Array(TelegramApi::Types::Update)
end

