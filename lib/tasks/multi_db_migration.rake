require 'open3'
require 'parallel'

namespace :multi_db_migration do
  desc 'migrate'
  task :migrate do
    ENV['RAILS_ENV'] ||= "development"
    config = MultiDbMigration::Config.new(config_path)
    parallel_migrate(config, false)
  end

  desc 'dry run'
  task :dry_run do
    ENV['RAILS_ENV'] ||= "development"
    config = MultiDbMigration::Config.new(config_path)
    parallel_migrate(config, true)
  end

  private

  def config_path
    @config_path ||= ENV.fetch('MULTI_DB_MIGRATION_CONFIG', MultiDbMigration::Config::DEFAULT_PATH)
  end

  def parallel_migrate(config, dry_run)
    shards = config.shards
    parallel_num = config.parallel_num

    ::Parallel.each(shards, in_threads: parallel_num) do |shard|
      migrate(config, shard, dry_run)
    end
  end

  def migrate(config, shard, dry_run)
    shard_config = config.shard_config(shard)

    client = MultiDbMigration::RidgepoleClient.new(
      env: ENV['RAILS_ENV'],
      config: config.db_config,
      file: shard_config[:file],
      spec_name: shard_config[:spec_name],
      dry_run: dry_run,
      ignore_tables: shard_config[:ignore_tables],
      skip_drop_table: shard_config[:skip_drop_table],
      mysql_change_table_comment: shard_config[:mysql_change_table_comment],
    )

    command = client.generate_command
    execute_command(shard, command)
  end

  def execute_command(shard, command)
    puts "[#{shard}] #{command}"

    is_success = Open3.popen2e(command) do |stdin, stdout_and_stderr, wait_thr|
      stdin.close

      stdout_and_stderr.each_line do |line|
        puts "[#{shard}] #{line}"
      end

      wait_thr.value.success?
    end

    exit(1) unless is_success
  end
end
