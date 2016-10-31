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
    @msg.match(/#(\w+)/).to_a
  end
  
  def valid?
    @msg.length < 140
  end
end