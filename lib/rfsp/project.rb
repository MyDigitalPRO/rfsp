class Project
  attr_accessor :id, :title, :body, :posted_at, :uri, :budget, :category

  def initialize
    category = {}
  end

  def rules
    @rules ||= Rules.new uri
  end

  def doc
    @doc ||= Client.get uri
  end

  def fetch
    self.title = rules.get_title doc
    self.body = rules.rules['fl.ru'][:page][:body].call(doc)
    self.posted_at = rules.get_posted_at doc
    self.budget = rules.get_budget doc
    self.category = rules.get_category doc
  end

end
