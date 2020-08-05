# frozen_string_literal: true

module CodebreakerOs
  class Difficulty
    LEVELS = { easy: { name: :easy, attempts: 15, hints: 2 },
               medium: { name: :medium, attempts: 10, hints: 1 },
               hell: { name: :hell, attempts: 5, hints: 1 } }.freeze

    attr_reader :level, :errors

    def initialize(name)
      @level = LEVELS.fetch(name&.to_sym) { nil }
      @errors = []
    end

    def valid?
      assert
      errors.empty?
    end

    private

    def assert
      errors << I18n.t(:'errors.difficulty') if @level.nil?
    end
  end
end
