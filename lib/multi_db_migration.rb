require 'active_support'
require 'active_support/core_ext'

require 'multi_db_migration/version'
require 'multi_db_migration/ridgepole_client'
require 'multi_db_migration/config'
require 'multi_db_migration/railtie' if defined?(::Rails::Railtie)

module MultiDbMigration
  class Error < StandardError; end
end
