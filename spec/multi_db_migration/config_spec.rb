RSpec.describe MultiDbMigration::Config do
  describe '#shards' do
    subject { described_class.new(path).shards }

    let(:path) { 'spec/fixtures/multi_db_migration.yml' }

    it { expect(subject).to eq %w[primary animals] }
  end

  describe '#shard_config' do
    subject { described_class.new(path).shard_config(shard) }

    let(:path) { 'spec/fixtures/multi_db_migration.yml' }
    let(:shard) { :primary }

    it do
      results = subject
      expect(results).not_to be_nil
    end
  end
end
