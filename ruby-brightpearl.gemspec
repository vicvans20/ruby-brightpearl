# frozen_string_literal: true

require_relative "lib/brightpearl/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-brightpearl"
  spec.version = Brightpearl::VERSION
  spec.authors = ["vicvans20"]
  spec.email = ["vicvans20@gmail.com"]

  spec.summary = "Brightpearl API ruby client."
  spec.description = "Simple Ruby client to interact with brightpearl API."
  spec.homepage = "https://github.com/vicvans20/ruby-brightpearl"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vicvans20/ruby-brightpearl"
  spec.metadata["changelog_uri"] = "https://github.com/vicvans20/ruby-brightpearl/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  # Runtime dependencies - what users need to use your gem
  spec.add_dependency 'httparty', '~> 0.20'

  # Development dependencies - what developers need to work on the gem
  spec.add_development_dependency("vcr", "~> 6.3.1")
  spec.add_development_dependency("webmock")
  spec.add_development_dependency("byebug")
  spec.add_development_dependency("rspec", "~> 3.0")
  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("dotenv")
  spec.add_development_dependency("pry")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
