# frozen_string_literal: true

require_relative 'codebreaker_os/uploader'
require_relative 'codebreaker_os/matching'
require_relative 'codebreaker_os/statistic'
require_relative 'game'
require_relative 'current_game'
class CodebreakerOs
  def self.run_game(name, difficulty)
    CurrentGame.new(Game.new(name, difficulty))
    CurrentGame.game.run
  end
end
