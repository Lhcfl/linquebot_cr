require "./app"
require "./plugins/**"

begin
  Linquebot.app.start_polling
rescue err : Linquebot::App::AppInitializeError
  STDERR.puts ""
  STDERR.puts "========== Initialize Failed ==========="
  STDERR.puts err.message
  exit 1
end