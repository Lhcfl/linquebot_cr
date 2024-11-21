require "./project"
class Linquebot::Logger
  private class EmptyIO < IO
    def initialize()
    end
  
    def read(slice)
      0
    end
  
    def write(slice) : Nil
    end
  end
  
  def self.debug
    if ENV.has_key?("PRODUCTION")
      EmptyIO.new
    else
      STDOUT
    end
  end

  def self.log
    STDOUT
  end
end

