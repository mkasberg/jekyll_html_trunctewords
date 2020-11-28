require 'jekyll-html-truncatewords/version'
require 'liquid'

module Jekyll
  module HtmlTruncatewords
    extend Liquid::StandardFilters
    
    extend self

    # Truncate HTML input to have `limit` words when rendered as HTML.
    # Preserve HTML structure so tags are correctly matched.
    def html_truncatewords(input, words = 15, truncate_string = "...")
      truncatewords(input, words, truncate_string)
    end
  end
end

Liquid::Template.register_filter(Jekyll::HtmlTruncatewords)
