module Jekyll
   module HtmlTruncatewords
      module Filter
         def html_truncatewords(html, limit)
            Core.html_truncatewords(html, limit)
         end
      end
   end
end


Liquid::Template.register_filter(Jekyll::HtmlTruncatewords::Filter)
