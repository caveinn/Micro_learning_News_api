require_relative "../app/models/categories"

newsapi = News.new(ENV["API_KEY"])

sources = newsapi.get_sources(country: 'us', language: 'en')

@categories = []
sources.each do |source|
  @categories.push(source.category)
end

@categories.uniq.each do |category|
  Category.create(name: category)
end