require 'nokogiri'
require 'rest_client'
require 'open-uri'
require 'feedjira'

class RFSP::Client
  UA = 'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0'

  def self.get uri
    # response = RestClient.get(uri, user_agent: UA)
    # raise "Response code is #{response.code}" if response.code != 200
    Nokogiri::HTML open(uri, "User-Agent" => UA)
  end

  def self.feed uri
    Feedjira::Feed.fetch_and_parse uri, user_agent: UA
  end
end
