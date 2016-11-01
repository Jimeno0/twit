require "Date"
require "pry"

class Twit
  attr_reader :img
  def initialize(msg, start_date = nil, end_date = nil)
    @start_date = start_date || Date.today - 1
    @end_date = end_date || Date.today + 1
    @msg = msg
    @img = nil
  end
  
  def status
    result = (@start_date..@end_date).to_a.include? Date.today
    result ? "visible" : "invisible"
  end
  
  def hashtags
    binding.pry
    @hashtags = []
    @msg.scan(/#(\w+)/).each { |hastag| @hashtags.push(hastag[0]) }
    @hashtags
  end
  
  def valid?
    @msg.length < 140
  end

  def load_img(img)
    allowed_formats = [".jpg",".png",".jpeg"]
    ext = File.extname(img)
    if allowed_formats.include? ext
      @img = img
    else
      "Unsuported format"
    end
    # @img = allowed_formats.include? ext ? img : "Unsuported format"

  end
end



twit = Twit.new ("esto es un twit valido con dos hastags #cool #twwethtat")
twit.hashtags



puts ""