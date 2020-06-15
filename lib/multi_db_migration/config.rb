require 'yaml'

module MultiDbMigration
  class Config
    DEFAULT_PATH = 'config/multi_db_migration.yml'
    DEFAULT_PARALLEL_NUM = 1
    DEFAULT_DB_CONFIG_PATH = 'config/database.yml'

    def initialize(path = nil)
      @path = path.presence || DEFAULT_PATH
    end

    def parallel_num
      config.dig(:parallel_num)&.to_i || DEFAULT_PARALLEL_NUM
    end

    def db_config
      config.dig(:db, :config) || DEFAULT_DB_CONFIG_PATH
    end

    def shards
      config.dig(:shards)&.keys || []
    end

    def shard_config(shard)
      config.dig(:shards, shard)
    end

    private

    def config
      @config ||= load_yaml
    end

    def load_yaml
      raise "#{@path} not found." unless ::File.exist?(@path)

      yaml = ::ERB.new(File.read(@path)).result
      ::YAML.safe_load(
        yaml,
        permitted_classes: [Symbol],
        permitted_symbols: [],
        aliases: true
      )&.with_indifferent_access
    end
  end
end
