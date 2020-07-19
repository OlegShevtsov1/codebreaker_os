# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Matching do
  let(:game) { Game.new('String', 'hell') }
  let(:values) { Uploader.get }

  context '#matching' do
    it 'it returns correct result with different values' do
      values.each do |value|
        game.instance_variable_set(:@secret_code, value[:secret_code].each_char.map(&:to_i))
        game.instance_variable_set(:@user_code, value[:input].each_char.map(&:to_i))
        expect(Matching.new(game).create_response).to eq(value[:result])
      end
    end
  end
end
