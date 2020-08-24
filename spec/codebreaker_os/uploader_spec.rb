# frozen_string_literal: true

RSpec.describe CodebreakerOs::Uploader do
  let(:storage_test_file) { 'test_file.yml' }
  let(:uploader) { described_class.new(storage_test_file) }
  let(:store) { uploader.new_store }

  after { File.delete storage_test_file }

  it 'creates new' do
    store.transaction { store[:winners] = [] }
    expect(uploader.storage_exists?).to be true
  end
end
