RSpec.describe MultiDbMigration::RidgepoleClient do
  describe '#generate_command' do
    subject { described_class.new(**options).generate_command }

    let(:options) { {} }

    context 'shard_config option' do
      context 'exists' do
        let(:options) { {shard_config: {options: ['--skip-drop-table']}} }

        it { expect(subject).to include('--skip-drop-table') }
      end
    end

    context 'env option' do
      context 'exists' do
        let(:options) { {env: :development} }

        it { expect(subject).to include('--env development') }
      end

      context 'not exists' do
        it { expect(subject).not_to include('--env') }
      end
    end

    context 'config option' do
      context 'exists' do
        let(:options) { {config: 'config/custom/database.yml'} }

        it { expect(subject).to include('--config config/custom/database.yml') }
      end

      context 'not exists' do
        it { expect(subject).to include('--config config/database.yml') }
      end
    end

    context 'dry run option' do
      context 'true' do
        let(:options) { {dry_run: true} }

        it { expect(subject).to include('--dry-run') }
      end

      context 'false' do
        let(:options) { {dry_run: false} }

        it { expect(subject).not_to include('--dry-run') }
      end

      context 'not exists' do
        it { expect(subject).to include('--dry-run') }
      end
    end
  end
end
