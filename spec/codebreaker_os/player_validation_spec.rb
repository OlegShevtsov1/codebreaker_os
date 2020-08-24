# frozen_string_literal: true

RSpec.describe CodebreakerOs::Player do
  context 'with name validation' do
    let(:above_max_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.max + 1) }
    let(:below_min_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.min - 1) }
    let(:non_string_names) { %w[111@ #@#$] }
    let(:empty_name) { '' }

    it 'name should be string' do
      non_string_names.each do |name|
        player = described_class.new(name)
        expect(player.valid?).to be false
      end
    end

    it 'name cannot be blank' do
      player = described_class.new(empty_name)
      expect(player.valid?).to be false
    end

    it 'min allowed name length' do
      player = described_class.new(below_min_length_name)
      expect(player.valid?).to be false
    end

    it 'max allowed name length' do
      player = described_class.new(above_max_length_name)
      expect(player.valid?).to be false
    end
  end

  context 'when valid user edge cases' do
    let(:min_length_name) { 'f' * described_class::NAME_LENGTH_RANGE.min }
    let(:max_length_name) { 'f' * described_class::NAME_LENGTH_RANGE.max }

    it 'creates player with min allowed length' do
      player = described_class.new(min_length_name)
      expect(player.valid?).to be true
    end

    it 'creates player with max allowed length' do
      player = described_class.new(max_length_name)
      expect(player.valid?).to be true
    end
  end
end
