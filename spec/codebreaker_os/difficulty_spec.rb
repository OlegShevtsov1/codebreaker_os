# frozen_string_literal: true

RSpec.describe CodebreakerOs::Difficulty do
  subject(:difficulty) { described_class }

  let(:correct_difficulty_name) { DIFFICULTY_LEVELS.keys.sample }
  let(:wrong_difficulty_names) { [:custom, nil] }

  it 'initialize' do
    expect(difficulty.new(correct_difficulty_name).level[:name]).to eql(correct_difficulty_name)
  end

  it 'not valid wrong difficulty name' do
    wrong_difficulty_names.each do |name|
      expect(difficulty.new(name).valid?).to be false
    end
  end
end
