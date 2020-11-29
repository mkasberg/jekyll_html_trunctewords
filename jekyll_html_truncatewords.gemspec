require_relative 'lib/jekyll_html_truncatewords/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll_html_truncatewords"
  spec.version       = JekyllHtmlTruncatewords::VERSION
  spec.authors       = ["Mike Kasberg"]
  spec.email         = ["mike@mikekasberg.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.} #TODO
  spec.description   = %q{Write a longer description or delete this line.} # TODO
  spec.homepage      = "https://www.mikekasberg.com" # TODO
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.mikekasberg.com" # TODO
  spec.metadata["changelog_uri"] = "https://www.mikekasberg.com" # TODO

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'liquid'
  spec.add_runtime_dependency 'liquid-c'
  spec.add_runtime_dependency 'nokogiri'
end