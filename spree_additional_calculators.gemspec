Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_additional_calculators'
  s.version     = '0.1.0'
  s.summary     = 'Additional calculators for spree'
  s.description = ''
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Jurgis Jurksta'
  # s.email             = ''
  s.homepage          = 'https://github.com/jurgis'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.50.2')
end
