require 'jekyll-html-truncatewords/version'
require 'liquid'
require 'nokogiri'

module Jekyll
  module HtmlTruncatewords
    extend Liquid::StandardFilters

    extend self

    # Truncate HTML input to have `limit` words when rendered as HTML.
    # Preserve HTML structure so tags are correctly matched.
    def html_truncatewords(input, words = 15, truncate_string = "...")
      words = words.to_i
      fragment = Nokogiri::HTML.fragment(input)

      if fragment.inner_text.split.length <= words
        return input
      end

      remaining = words
      fragment.children.each do |n|
        if remaining > 0
          remaining = truncate_node(n, remaining, truncate_string)
        else
          n.remove
        end
      end

      fragment.to_s
    end

    # Truncate the node if necessary.
    # Return the words remaining after accounting for the current node.
    private def truncate_node(node, words_remaining, truncate_string)
      if node.text?
        wordlist = node.text.to_s.split
        if wordlist.length < words_remaining
          return words_remaining - wordlist.length
        elsif wordlist.length == words_remaining
          node.content = node.content.rstrip + truncate_string
          return 0
        else
          node.content = truncatewords(node.text, words_remaining, truncate_string)
          return 0
        end
      else
        node.children.each do |n|
          if words_remaining > 0
            words_remaining = truncate_node(n, words_remaining, truncate_string)
          else
            n.remove
          end
        end
        
        return words_remaining
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::HtmlTruncatewords)
