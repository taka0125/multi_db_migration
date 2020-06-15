module MultiDbMigration
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/multi_db_migration.rake'
    end
  end
end
