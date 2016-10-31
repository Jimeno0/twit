require_relative '../app/twit.rb'
require 'date'

RSpec.describe Twit do
  
  describe ".status" do
    it "is visible when date is between start and end" do
      start_date = Date.today - 1
      end_date = Date.today + 1
      twit = Twit.new("message", start_date, end_date)
      expect(twit.status).to eq("visible")
    end
    
    it "is invisible when date is not between start and end" do
      start_date = Date.today + 1
      end_date = Date.today + 10
      twit = Twit.new("message", start_date, end_date)
      expect(twit.status).to eq("invisible")
    end
  end
  
  describe "tweet message length" do
    it "is invalid over 140 characters" do
      str = "*" * 141
      twit = Twit.new(str)
      
      expect(twit.valid?).to eq(false)
      #expect { Twit.new(str) }.to raise_error
    end
    
    it "is valid under 140" do
      str = "*" * 139
      twit = Twit.new(str)
      
      expect(twit.valid?).to eq(true)
    end
  end
  
  describe ".hashtags" do
    it "extracts the correct amount of hashtags" do
      msg = "chicos y chicas no es chiques #feminism, #machirulo"
      twit = Twit.new(msg)
      expect(twit.hashtags).to eql(2)
    end
  
    it "works for zero hashtags" do
      msg = "chicos y chicas no es chiques"
      twit = Twit.new(msg)
      expect(twit.hashtags.size).to eql(0)
    end
    
    it "returns the correct hashtgas" do
      msg = "chicos y chicas no es chiques #feminism"
      twit = Twit.new(msg)
      expect(twit.hashtags).to include("#feminism")
    end
  end
end


