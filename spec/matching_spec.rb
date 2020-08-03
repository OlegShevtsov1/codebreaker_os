# frozen_string_literal: true

RSpec.describe Matching do
  let(:game) { Game.new('String', 'hell') }
  let(:values) { Uploader.get }

  describe '#matching' do
    it 'returns correct result with different values' do
      values.each do |value|
        game.instance_variable_set(:@secret_code, value[:secret_code].each_char.map(&:to_i))
        game.instance_variable_set(:@user_code, value[:input].each_char.map(&:to_i))
        expect(described_class.new(game).create_response).to eq(value[:result])
      end
    end
  end

  # describe 'ruby_garage_tests' do
  #   [
  #       [[6, 5, 4, 1], [6, 5, 4, 1], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE]],
  #       [[1, 2, 2, 1], [2, 1, 1, 2], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE,
  #                                     Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[6, 2, 3, 5], [2, 3, 6, 5], [Game::GUESS_PLACE, Game::GUESS_PRESENCE,
  #                                     Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [4, 3, 2, 1], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE,
  #                                     Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [1, 2, 3, 5], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE]],
  #       [[1, 2, 3, 4], [5, 4, 3, 1], [Game::GUESS_PLACE, Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [1, 5, 2, 4], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [4, 3, 2, 6], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [3, 5, 2, 5], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [5, 6, 1, 2], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
  #       [[5, 5, 6, 6], [5, 6, 0, 0], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [6, 2, 5, 4], [Game::GUESS_PLACE, Game::GUESS_PLACE]],
  #       [[1, 2, 3, 1], [1, 1, 1, 1], [Game::GUESS_PLACE, Game::GUESS_PLACE]],
  #       [[1, 1, 1, 5], [1, 2, 3, 1], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [4, 2, 5, 5], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
  #       [[1, 2, 3, 4], [5, 6, 3, 5], [Game::GUESS_PLACE]],
  #       [[1, 2, 3, 4], [6, 6, 6, 6], []],
  #       [[1, 2, 3, 4], [2, 5, 5, 2], [Game::GUESS_PRESENCE]]
  #   ].each do |item|
  #     it "when result is #{item[2]} if code is - #{item[0]}, guess is #{item[1]}" do
  #       game.instance_variable_set(:@breaker_numbers, item[0])
  #       guess = item[1]
  #       expect(game.start_round(guess)).to eq item[2]
  #     end
  #   end
  # end
end
