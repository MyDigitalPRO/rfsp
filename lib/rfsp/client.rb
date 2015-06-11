require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'feedjira'

class RFSP::Client
  UA = 'Mozilla/5.0 (Windows NT 6.3; rv:39.0) Gecko/20100101 Firefox/39.0'

  def self.get uri
    # response = RestClient.get(uri, user_agent: UA)
    # raise "Response code is #{response.code}" if response.code != 200
    Nokogiri::HTML open(uri, "User-Agent" => UA)
  end

  def self.feed uri
    Feedjira::Feed.fetch_and_parse uri, user_agent: UA
  end
end
