# frozen_string_literal: true

require_relative "lib/server_timing/version"

Gem::Specification.new do |spec|
  spec.name = "server_timing-ts"
  spec.version = ServerTiming::VERSION
  spec.authors = ["derekstride"]
  spec.email = ["derek.stride@shopify.com"]

  spec.summary = "A Server-Timing header parser for Ruby using Tree-sitter."
  spec.description = "A Server-Timing header parser for Ruby using Tree-sitter."
  spec.homepage = "https://github.com/derekstride/server_timing-ts"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby_tree_sitter", "~> 1.11"
end
