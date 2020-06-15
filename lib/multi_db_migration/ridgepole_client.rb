module MultiDbMigration
  class RidgepoleClient
    def initialize(shard_config: nil, env: nil, config: nil, dry_run: true)
      @shard_config = shard_config.presence || {}
      @env = env
      @config = config.presence || MultiDbMigration::Config::DEFAULT_DB_CONFIG_PATH
      @dry_run = dry_run
    end

    def generate_command
      "bundle exec ridgepole #{command_options.join(' ')}"
    end

    private

    def command_options
      options = @shard_config.dig(:options) || []
      options << env_option
      options << config_option
      options << dry_run_option
      options << '--apply'
      options.compact
    end

    def env_option
      return if @env.blank?

      "--env #{@env}"
    end

    def config_option
      return if @config.blank?

      "--config #{@config}"
    end

    def dry_run_option
      return if @dry_run.blank?

      "--dry-run"
    end
  end
end
