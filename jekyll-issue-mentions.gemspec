Gem::Specification.new do |s|
  s.name        = "jekyll-issue-mentions"
  s.summary     = "#issueid support for your Jekyll site"
  s.version     = "0.1.1"
  s.authors     = ["Harish Shetty"]
  s.email       = "support@workato.com"

  s.homepage    = "https://github.com/workato/jekyll-issue-mentions"
  s.licenses    = ["MIT"]
  s.files       = ["lib/jekyll-issue-mentions.rb", "lib/issue_mention_filter.rb" ]

  s.add_dependency "jekyll", '~> 2.0'
  s.add_dependency "html-pipeline", '~> 1.9.0'

  s.add_development_dependency  'rake'
  s.add_development_dependency  'rdoc'
  s.add_development_dependency  'shoulda'
  s.add_development_dependency  'minitest'
end
