# MultiDbMigration

Multiple database migration use ridgepole

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multi_db_migration'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install multi_db_migration

## Configuration

- `config/multi_db_migration.yml`

```yaml
parallel_num: 1
db:
  config: config/database.yml
shards:
  primary:
    options:
      - --spec-name=primary
      - --ignore-tables=^need_ignore_tables$
      - --skip-drop-table
      - --file=db/schemas/primary/Schemafile
  animals:
    options:
      - --spec-name=animals
      - --ignore-tables=^need_ignore_tables$
      - --skip-drop-table
      - --file=db/schemas/animals/Schemafile
```

## ENV

| Name | Default | Description |
| --- | --- | --- |
| MULTI_DB_MIGRATION_CONFIG | config/multi_db_migration.yml | path for multi_db_migration.yml |

## Usage

- dry run

```
bundle rake multi_db_migration:dry_run
```

- migrate

```
bundle rake multi_db_migration:migrate
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/taka0125/multi_db_migration.

