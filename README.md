# JekyllHtmlTruncatewords

**[Published on RubyGems](https://rubygems.org/gems/jekyll_html_truncatewords)**

A Jekyll filter to truncate HTML to a specified number of words. The Liquid `truncatewords` filter can't operate accurately on HTML because it isn't aware of tags. But Jekyll blog posts usually contain HTML, so this makes it difficult to, for example, use the first 50 words of a blog post as the preview. jekyll_html_truncatewords solves that problem. It works the same as `truncatewords`, but it is aware of HTML tags so it counts words correctly within HTML and won't break HTML.

### Is this ready for production?

I'm using this in production on some small sites. I'm confident that it handles almost everything correctly, but it might be the case that unusual HTML produces some strange results. If you encounter any incorrect behavior, please open an issue here on GitHub and I'll try to implement a fix. Pull requests are also welcome, of course.

## Installation

This is a Jekyll plugin, and can be installed using any of the [supported
methods](https://jekyllrb.com/docs/plugins/installation/).

We recommend simply adding the gem to the `:jekyll_plugins` group in your
`Gemfile`:

```ruby
group :jekyll_plugins do
  gem 'jekyll_html_truncatewords', '~> 0.1'
end
```

## Usage

```
{{ post.content | html_truncatewords: 50 }}
```

## Development Notes

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mkasberg/jekyll_html_truncatewords.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
