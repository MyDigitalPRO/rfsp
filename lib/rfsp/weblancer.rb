require_relative 'client'
require 'ostruct'
require 'nokogiri'

class RFSP::Weblancer
  RSS_URI = 'http://www.weblancer.net/rss/jobs.rss'

  class << self

    def parse_rss
      projects = []
      # binding.pry
      feed.entries.each do |e|
        p = OpenStruct.new
        p.site = 'weblancer'
        p.uri = e.url
        p.id = e.url.match(/(\d+)/)[1].to_i
        p.published = e.published
        p.body = e.summary
        p.title = e.title
        body_doc = Nokogiri::HTML p.body
        p.category = body_doc.search('a').select{|c| c.attr('href')['projects/?category_id=']}.map(&:text).join ', '
        if amount2 = body_doc.search('.amount_2').first
          budget = OpenStruct.new
          budget.origin = amount2.text
          m = budget.origin.match(/(\d+) (\w+)/)
          budget.amount = m[1].to_i
          budget.currency = m[2].downcase
          p.budget = budget
        end
        p.body.sub!(/\n.+<br \/><br \/>/, '')
        projects << p
      end
      projects
    end

    def feed
      @@feed ||= update
    end

    def update
      @@feed = RFSP::Client.feed RSS_URI
    end

  end

end
