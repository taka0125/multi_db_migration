require_relative 'lib/multi_db_migration/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_db_migration"
  spec.version       = MultiDbMigration::VERSION
  spec.authors       = ["Takahiro Ooishi"]
  spec.email         = ["taka0125@gmil.com"]

  spec.summary       = %q{Multiple database migration use ridgepole}
  spec.description   = %q{Multiple database migration use ridgepole}
  spec.homepage      = "https://github.com/taka0125/multi_db_migration"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.3")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/taka0125/multi_db_migration"
  spec.metadata["changelog_uri"] = "https://github.com/taka0125/multi_db_migration/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ridgepole", ">= 0.8"
  spec.add_dependency "activesupport", ">= 5.0"
  spec.add_dependency "parallel"
end
