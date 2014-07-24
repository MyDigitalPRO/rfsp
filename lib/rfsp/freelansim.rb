require_relative 'client'
require 'ostruct'

class RFSP::Freelansim
  RSS_URI = 'http://freelansim.ru/rss/tasks'

  class << self

    def parse_rss
      projects = []
      feed.entries.each do |e|
        p = OpenStruct.new
        p.uri = e.url
        p.id = e.url.match(/(\d+)/)[1].to_i
        p.published = e.published
        p.body = e.summary
        p.title = e.title
        p.site = 'freelansim'
        projects << p
      end
      projects
    end


    def parse_budget_and_tags project
      doc = RFSP::Client.get project.uri
      price = doc.search('.task__price .count').first
      if price
        budget = OpenStruct.new
        budget.origin = price.text
        budget.amount = budget.origin.match(/([\d ]+)/)[1].gsub(' ', '').to_i
        budget.currency = 'rur' if budget.origin['руб.']
      end
      project.budget = budget
      project.tags = doc.search('.tags a').map(&:text).join ', '
      project
    end

    alias :parse_page :parse_budget_and_tags

    def feed
      @@feed ||= update
    end

    def update
      @@feed = RFSP::Client.feed RSS_URI
    end

  end

end
