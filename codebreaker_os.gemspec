# frozen_string_literal: true

require_relative 'lib/codebreaker_os/version'

Gem::Specification.new do |s|
  s.required_ruby_version = Gem::Requirement.new('>= 2.6.6')

  s.name          = 'codebreaker_os'
  s.version       = CodebreakerOs::VERSION
  s.summary       = 'Codebreaker game through user interaction'
  s.authors       = ['Oleg Shevtsov']
  s.email         = 'olegshevtsov1@gmail.com'
  s.homepage      = 'https://github.com/olegshevtsov1/codebreaker_os'
  s.license       = 'MIT'
  s.require_paths = 'lib'

  s.add_development_dependency 'faker', '~> 2.13'
  s.add_development_dependency 'fasterer', '~> 0.8.3'
  s.add_development_dependency 'pry', '~> 0.13.1'
  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  s.add_development_dependency 'rubocop', '~> 0.87.1'
  s.add_development_dependency 'rubocop-rspec', '~> 1.42'
  s.add_development_dependency 'simplecov', '~> 0.18.5'

  # s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  s.files = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
end
