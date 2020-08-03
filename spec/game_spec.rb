# frozen_string_literal: true

RSpec.describe Game do
  # DIFFICULTIES = {
  #   easy: { attempts: 15, hints: 2 },
  #   medium: { attempts: 10, hints: 1 },
  #   hell: { attempts: 5, hints: 1 }
  # }.freeze

  let(:game) { described_class.new('String', 'hell') }

  before do
    stub_const('DIFFICULTIES', {
                 easy: { attempts: 15, hints: 2 },
                 medium: { attempts: 10, hints: 1 },
                 hell: { attempts: 5, hints: 1 }
               })
    game.run
  end

  describe '#initialize' do
    context 'when correct difficulty' do
      it 'creates game with different difficult' do
        DIFFICULTIES.each do |name, difficult|
          current_game = described_class.new('Name', name.to_s)
          expect(current_game.attempts).to eq difficult[:attempts]
          expect(current_game.hints).to eq difficult[:hints]
          expect(current_game.difficulty_name).to eq DIFFICULTIES.key(difficult).to_s
        end
      end
    end
  end

  describe '#game' do
    describe '#when generate secret code' do
      it 'is not empty' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saveses 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).length).to eq 4
      end

      it 'saveses secret code with numbers from 1 to 6' do
        game.instance_variable_get(:@secret_code).each do |number|
          expect(number).to be_between(1, 6).inclusive
        end
      end
    end

    context 'when give hint' do
      it 'returns number wich contains secret code' do
        expect(game.secret_code).to include(game.use_hint)
      end
    end

    context 'when ended game' do
      it 'return won if result secret code' do
        expect(game.won?(game.secret_code)).to eq true
      end

      it 'return lost if result wrong secret code' do
        expect(game.won?(game.secret_code.sort_by { rand })).to eq false
      end

      it 'return lost if attempts == zero' do
        expect(game.lost?).to eq false
      end

      it 'return lost  if attempts == zero' do
        game.attempts = 0
        expect(game.lost?).to eq true
      end
    end
  end

  describe '#file' do
    context 'when get stats' do
      it 'creates statistic file if file does not exist' do
        expect(Statistic.stats).to be_a Array
      end
    end
  end
end
