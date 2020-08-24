# frozen_string_literal: true

module CodebreakerOs
  class Guess
    attr_reader :value, :errors

    def initialize(value)
      @value = value
      @errors = []
    end

    def valid?
      assert
      errors.empty?
    end

    def self.decorate(value)
      value.gsub(CodebreakerOs::Game::EXACT_MATCH_SIGN, '+')
           .gsub(CodebreakerOs::Game::NOT_EXACT_MATCH_SIGN, '-')
    end

    private

    def assert
      validate_length
      validate_range if errors.empty?
    end

    def validate_length
      error_message = I18n.t(:'errors.guess.length', length: Game::SECRET_CODE_LENGTH)
      errors << error_message unless @value.to_s.chars.length == Game::SECRET_CODE_LENGTH
    end

    def validate_range
      error_message = I18n.t(:'errors.guess.range', range: Game::SECRET_CODE_RANGE)
      allowed_range = Game::SECRET_CODE_RANGE.to_a
      is_valid_range = @value.to_s.chars.map(&:to_i).all? { |n| allowed_range.include? n }
      errors << error_message unless is_valid_range
    end
  end
end
