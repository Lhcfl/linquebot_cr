require "event_emitter"

emitter = EventEmitter::Base.new
emitter.on :message do |*body|
  puts "> #{body}"
end

emitter.emit :message, {"Hello, world!", 1}
sleep 200.milliseconds
emitter.emit :message, {"Hello, world!", 1}