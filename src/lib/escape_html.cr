module Linquebot::Lib
  def escape_html(str : String)
    str.each_char.map do |c|
      case c
      when .== '&' then "&amp;"
      when .== '<' then "&lt;"
      when .== '>' then "&gt;"
      else c
      end
    end
    .join("")
  end
end