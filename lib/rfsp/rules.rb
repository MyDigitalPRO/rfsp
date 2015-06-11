require_relative 'project'
require 'uri'
class Rules

  def initialize uri
    @uri = uri
    @domain = URI(uri).host.sub /\Awww\./, ''
  end

  def projects_from_page doc
    projects = []
    rules[@domain][:index][:projects].call(doc).each do |url|
      p = Project.new
      p.id = rules[@domain][:id_from_url].call(url)
      p.uri = URI.join(@uri, url).to_s
      projects << p
    end
    projects
  end

  def get_title doc
    rules[@domain][:page][:title].call(doc)
  end

  def get_body doc
    rules[@domain][:page][:body].call(doc)
  end

  def get_posted_at doc
  end

  def get_budget doc
  end

  def get_category doc
  end

  def get_project_info project
  end

  def rules
    @rules ||= {
      'fl.ru' => {
        index: {
          projects: ->(doc){doc.search('a.b-post__link').map{|e| e.attr 'href'}.uniq}
        },
        page: {
          title: ->(doc){doc.search('h1.b-page__title').first.text},
          body: ->(doc){doc.search(".projectp#{id}").first.inner_html.encode('utf-8')},
          posted_at: ->(doc){doc.search('div.b-layout__txt').first.inner_html},
        },
        id_from_url: ->(url){url.match(%r{\A/projects/(\d+)/})[1].to_i}
      }
    }
  end
end
