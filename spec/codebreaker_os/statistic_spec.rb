# frozen_string_literal: true

RSpec.describe CodebreakerOs::Statistic do
  let(:test_statistics_file) { 'spec/codebreaker_os/fixtures/statistics.yml' }
  let(:winners) { YAML.load_file(test_statistics_file)[:winners] }
  let(:not_sorted_players_order) { %w[Foo1 Foo1 Foo2 Foo3] }
  let(:sorted_players_order) { %w[Foo1 Foo1 Foo3 Foo2] }
  let(:sorted_winners) { described_class.sorted_winners(winners) }
  let(:top_players) { described_class.decorated_top_players(sorted_winners) }
  let(:expected_table_fields) { %i[rating name difficulty attempts_total attempts_used hints_total hints_used] }

  context 'when reads not sorted winners' do
    it 'reads sample file' do
      expect(winners.map(&:player).map(&:name)).to eq(not_sorted_players_order)
    end
  end

  context 'when sorted winners' do
    it 'sort winners' do
      expect(sorted_winners.map(&:player).map(&:name)).to eq(sorted_players_order)
    end

    it 'decorates winners' do
      expect(top_players.sample.keys).to eq(expected_table_fields)
    end
  end
end
