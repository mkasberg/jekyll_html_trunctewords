require 'jekyll-html-truncatewords/core'
require 'jekyll-html-truncatewords/version'

if defined?(Jekyll) && defined?(Liquid)
  require 'jekyll-html-truncatewords/jekyll_integration'
end

module Jekyll
  module HtmlTruncatewords
    extend self

    def html_truncatewords(html, limit)
      Core.html_truncatewords(html, limit)
    end
  end
end
