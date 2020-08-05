# frozen_string_literal: true

GUESS_PLACE = '+'
GUESS_PRESENCE = '-'

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter 'spec/'
  minimum_coverage 95
end

require 'codebreaker_os'

RSpec.configure do |config|
  DIFFICULTY_LEVELS = { easy: :easy, medium: :medium, hell: :hell }.freeze

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def random_number(length, range)
  Array.new(length) { rand(range) }.join
end
