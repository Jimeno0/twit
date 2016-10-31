require "Date"
require "pry"

class Twit
  def initialize(msg, start_date = nil, end_date = nil)
    @start_date = start_date || Date.today - 1
    @end_date = end_date || Date.today + 1
    @msg = msg
  end
  
  def status
    result = (@start_date..@end_date).to_a.include? Date.today
    result ? "visible" : "invisible"
  end
  
  def hashtags
    
    @hashtags = []
    @msg.scan(/#(\w+)/).each { |hastag| @hashtags.push(hastag[0]) }
    @hashtags
  end
  
  def valid?
    @msg.length < 140
  end
end



# twit = Twit.new ("esto es un twit valido con dos hastags #cool #twwethtat")
# twit.hashtags

# puts ""