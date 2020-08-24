# frozen_string_literal: true

RSpec.describe CodebreakerOs::Game do
  let(:name) { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  let(:difficulty) { CodebreakerOs::Difficulty.new(DIFFICULTY_LEVELS.keys.sample) }
  let(:game) { described_class.new(CodebreakerOs::Player.new(name), difficulty) }

  it 'has player' do
    expect(game.player.name).to eql name
  end

  context 'when lost game' do
    let(:secret_number) { '2442' }

    before do
      game.instance_variable_set(:@secret_number, secret_number)
    end

    it 'has no attempts available' do
      (game.difficulty[:attempts] + 1).times { game.compare('1111') }
      expect(game.attempts_available?).to be false
    end
  end

  it 'hints' do
    expect(game.hint).to be_truthy
  end

  it 'no hints' do
    (game.difficulty[:hints] + 1).times { game.hint }
    expect(game.hint).to be_falsey
  end

  describe 'ruby_garage_tests' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], [GUESS_PLACE, GUESS_PLACE, GUESS_PLACE, GUESS_PLACE]],
      [[1, 2, 2, 1], [2, 1, 1, 2], [GUESS_PRESENCE, GUESS_PRESENCE,
                                    GUESS_PRESENCE, GUESS_PRESENCE]],
      [[6, 2, 3, 5], [2, 3, 6, 5], [GUESS_PLACE, GUESS_PRESENCE,
                                    GUESS_PRESENCE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 3, 2, 1], [GUESS_PRESENCE, GUESS_PRESENCE,
                                    GUESS_PRESENCE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [1, 2, 3, 5], [GUESS_PLACE, GUESS_PLACE, GUESS_PLACE]],
      [[1, 2, 3, 4], [5, 4, 3, 1], [GUESS_PLACE, GUESS_PRESENCE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [1, 5, 2, 4], [GUESS_PLACE, GUESS_PLACE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 3, 2, 6], [GUESS_PRESENCE, GUESS_PRESENCE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [3, 5, 2, 5], [GUESS_PRESENCE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [5, 6, 1, 2], [GUESS_PRESENCE, GUESS_PRESENCE]],
      [[5, 5, 6, 6], [5, 6, 0, 0], [GUESS_PLACE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [6, 2, 5, 4], [GUESS_PLACE, GUESS_PLACE]],
      [[1, 2, 3, 1], [1, 1, 1, 1], [GUESS_PLACE, GUESS_PLACE]],
      [[1, 1, 1, 5], [1, 2, 3, 1], [GUESS_PLACE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 2, 5, 5], [GUESS_PLACE, GUESS_PRESENCE]],
      [[1, 2, 3, 4], [5, 6, 3, 5], [GUESS_PLACE]],
      [[1, 2, 3, 4], [6, 6, 6, 6], []],
      [[1, 2, 3, 4], [2, 5, 5, 2], [GUESS_PRESENCE]]
    ].each do |item|
      it "when result is #{item[2]} if code is - #{item[0]}, guess is #{item[1]}" do
        game.instance_variable_set(:@secret_number, item[0].join)
        guess = item[1].join
        expect(CodebreakerOs::Guess.decorate(game.compare(guess))).to eq item[2].join
      end
    end
  end
end
