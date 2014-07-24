require_relative 'client'
require 'ostruct'

class RFSP::Fl
  RSS_URI = 'https://www.fl.ru/rss/all.xml'

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
        p.site = 'fl'
        p.category = e.categories.map{|c| c.gsub(/<\/?.+?>/, '')}.join ', '
        budget_regexp = / \(Бюджет: (\d+) +(руб|\$)\.?\)\Z/
        if m = p.title.match(budget_regexp)
          budget = OpenStruct.new
          budget.origin = m[0]
          budget.origin[' ('] = ''
          budget.origin[')'] = ''
          budget.amount = m[1].to_i
          budget.currency = m[2] == '$' ? 'usd' : m[2] == 'руб' ? 'rur' : nil
          p.budget = budget
          p.title.sub! budget_regexp, ''
        end
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
