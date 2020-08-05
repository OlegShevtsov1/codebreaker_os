# frozen_string_literal: true

RSpec.describe CodebreakerOs::Guess do
  context 'when guess validation' do
    let(:non_digit) { '#$jhs' }
    let(:empty) { '' }
    let(:negative) { (random_number(4, (1..6)).to_i * -1) }

    it 'have digits' do
      expect(described_class.new(non_digit).valid?).to be false
    end

    it 'not empty' do
      expect(described_class.new(empty).valid?).to be false
    end

    it 'is positive' do
      expect(described_class.new(negative).valid?).to be false
    end

    context 'with length' do
      let(:max_range_outbound) { random_number(5, (1..6)) }
      let(:below_range) { random_number(3, (1..6)) }

      it 'not valid max range outbound' do
        expect(described_class.new(max_range_outbound).valid?).to be false
      end

      it 'not valid min range outbound' do
        expect(described_class.new(below_range).valid?).to be false
      end
    end

    context 'with range' do
      let(:valid_range) { random_number(4, (1..6)) }
      let(:not_valid_range) { random_number(4, (7..12)) }

      it 'valid' do
        expect(described_class.new(valid_range).valid?).to be true
      end

      it 'not valid' do
        expect(described_class.new(not_valid_range).valid?).to be false
      end
    end
  end
end
