Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_additional_calculators'
  s.version     = '1.0.0'
  s.summary     = 'Additional calculators for spree'
  s.description = 'Allows to calculate shipping costs based on total item weigh and quantity in the order'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Jurgis Jurksta'
  s.email             = 'jurgis@emails.lv'
  s.homepage          = 'https://github.com/jurgis/spree-additional-calculators'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.0.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
end
