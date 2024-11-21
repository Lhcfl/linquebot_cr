require "../spec_helper"
require "../../src/lib/escape_html"

describe Linquebot::Lib do
  it "should respect non-special characters" do
    [
      "abc",
      "abc def",
      "中文",
      ""
    ].each do |str|    
      Linquebot::Lib.escape_html(str).should eq(str)
    end
  end

  it "will escape special characters" do
    Linquebot::Lib.escape_html("<abc>").should eq("&lt;abc&gt;")
    Linquebot::Lib.escape_html("a&&&b").should eq("a&amp;&amp;&amp;b")
  end
end
