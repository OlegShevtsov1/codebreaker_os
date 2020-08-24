# frozen_string_literal: true

module CodebreakerOs
  class Game
    SECRET_CODE_LENGTH = 4
    SECRET_CODE_RANGE = (1..6).freeze
    EXACT_MATCH_SIGN = '1'
    NOT_EXACT_MATCH_SIGN = '0'

    attr_reader :player, :difficulty, :secret_number, :hints_used, :attempts_used

    def initialize(player, difficulty)
      @player = player
      @difficulty = difficulty.level
      @secret_number = code_maker
      assign_hints
      @hints_used = 0
      @attempts_used = 0
    end

    def hints_total
      @difficulty[:hints]
    end

    def attempts_total
      @difficulty[:attempts]
    end

    def attempt
      @attempts_used += 1
    end

    def increment_hint
      @hints_used += 1
    end

    def hints_available?
      @hints_used < @difficulty[:hints]
    end

    def attempts_available?
      @attempts_used < @difficulty[:attempts]
    end

    def win?(player_number)
      secret_number == player_number.to_s
    end

    def compare(player_number)
      return EXACT_MATCH_SIGN * SECRET_CODE_LENGTH if win?(player_number) || !attempts_available?

      attempt
      compare_numbers(player_number)
    end

    def hint
      increment_hint if hints_available?

      @hints.pop
    end

    private

    def assign_hints
      @hints = @secret_number.chars.shuffle.sample(difficulty[:hints])
    end

    def code_maker
      Array.new(SECRET_CODE_LENGTH) { rand(SECRET_CODE_RANGE) }.join.to_s
    end

    def compare_numbers(player_number)
      secret_digits = @secret_number.chars
      player_digits = player_number.chars
      output = strong_match(secret_digits, player_digits)
      output += not_strong_match(secret_digits, player_digits)
      output
    end

    def strong_match(secret_digits, player_digits)
      output = ''
      secret_digits.each_with_index do |digit, index|
        next unless digit == player_digits[index]

        output += EXACT_MATCH_SIGN
        secret_digits[index] = nil
        player_digits[index] = nil
      end
      output
    end

    def not_strong_match(secret_digits, player_digits)
      output = ''
      secret_digits.each do |digit|
        next unless digit && player_digits.include?(digit)

        output += NOT_EXACT_MATCH_SIGN
        player_digits.delete_at(player_digits.index(digit))
      end
      output
    end
  end
end
