require 'jekyll_html_truncatewords/version'
require 'liquid'
require 'nokogiri'

module JekyllHtmlTruncatewords
  # Extending Liquid::StandardFilters allows us to call the Liquid version of truncatewords
  # instead of re-creating our own.
  extend Liquid::StandardFilters

  extend self

  # Truncate HTML input to have `words` words when rendered as HTML.
  # Preserve HTML structure so tags are correctly matched.
  def html_truncatewords(input, words = 15, truncate_string = "...")
    words = words.to_i
    fragment = Nokogiri::HTML.fragment(input)

    if fragment.inner_text.split.length <= words
      return input
    end

    truncate_node(fragment, words, truncate_string)

    fragment.to_html
  end

  # A recursive function to truncate the node, if necessary.
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
        node.content = truncate_text(node.text, words_remaining, truncate_string)
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

  private def truncate_text(input, words, truncate_string)
    leading_spaces = input.match(/^[ ]+/)
    lead = leading_spaces.nil? ? '' : leading_spaces[0]
    
    lead + truncatewords(input, words, truncate_string)
  end
end

Liquid::Template.register_filter(JekyllHtmlTruncatewords)
