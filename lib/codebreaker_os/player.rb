# frozen_string_literal: true

module CodebreakerOs
  class Player
    NAME_LENGTH_RANGE = (3..20).freeze

    attr_reader :name, :created_at, :errors

    def initialize(name)
      @name = name
      @created_at = DateTime.now
      @errors = []
    end

    def valid?
      assert
      errors.empty?
    end

    private

    def assert
      validate_not_empty
      validate_string if errors.empty?
      validate_min_length if errors.empty?
      validate_max_length if errors.empty?
    end

    def validate_not_empty
      errors << I18n.t(:'errors.player.blank_name') if name.to_s.strip.empty?
    end

    def validate_string
      errors << I18n.t(:'errors.player.non_string_name') unless !!(name =~ /\A[a-zA-Z_0-9]+\z/)
    end

    def validate_min_length
      min_length = NAME_LENGTH_RANGE.min
      errors << I18n.t(:'errors.player.min_length_name', length: min_length) if name.length < min_length
    end

    def validate_max_length
      max_length = NAME_LENGTH_RANGE.max
      errors << I18n.t(:'errors.player.max_length_name', length: max_length) if name.length > max_length
    end
  end
end
