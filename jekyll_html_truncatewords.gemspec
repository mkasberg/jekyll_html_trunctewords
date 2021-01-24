require_relative 'lib/jekyll_html_truncatewords/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll_html_truncatewords"
  spec.version       = JekyllHtmlTruncatewords::VERSION
  spec.authors       = ["Mike Kasberg"]
  spec.email         = ["mike@mikekasberg.com"]

  spec.summary       = %q{A Jekyll filter to truncate HTML}
  spec.description   = %q{A Jekyll filter to truncate HTML to a specified number of words. The Liquid truncatewords filter can't operate on HTML because it isn't aware of tags. But Jekyll blog posts usually contain HTML, so this makes it difficult to, for example, use the first 50 words of a blog post as the preview. jekyll_html_truncatewords solves that problem. It works the same as truncatewords, but it is aware of HTML tags so it counts words correctly within HTML and won't break HTML.}
  spec.homepage      = "https://github.com/mkasberg/jekyll_html_trunctewords"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/mkasberg/jekyll_html_trunctewords/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'liquid'
  spec.add_runtime_dependency 'nokogiri'
end
