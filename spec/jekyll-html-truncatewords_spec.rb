require 'spec_helper'

RSpec.describe Jekyll::HtmlTruncatewords do
  it "has a version number" do
    expect(Jekyll::HtmlTruncatewords::VERSION).not_to be nil
  end

  it "works as a Liquid template" do
    input = "<p>This is a sentence with more than 5 words.</p>"
    liquid = "{{ '#{input}' | html_truncatewords: 5, '~!' }}"
    output = Liquid::Template.parse(liquid).render()
    expect(output).to eq('<p>This is a sentence with~!</p>')
  end

  context 'examples' do
    def check(input, words, expected)
      output = Jekyll::HtmlTruncatewords.html_truncatewords(input, words)
      expect(output).to eq(expected)
    end

    it "doesn't change input under limit with no HTML" do
      input = 'foo bar'
      check(input, 10, input)
    end

    it "truncates words to the limit" do
      check('foo bar', 1, 'foo...')
    end

    it "doesn't count tags as words" do
      input = "<p>foo bar</p>"
      check(input, 2, input)
    end

    it "truncates text inside a single tag" do
      input = '<p>This is a sentence with more than 5 words.</p>'
      expected = '<p>This is a sentence with...</p>'
      check(input, 5, expected)
    end

    it "handles sibling tags" do
      input = "<p>foo</p><p>bar</p>"
      check(input, 10, input)
    end

    it 'truncates sibling tags correctly' do
      input = '<p>This is the first paragraph.</p><p>This is the second paragraph.</p><p>This is the third paragraph.</p>'
      expected = '<p>This is the first paragraph.</p><p>This is the...</p>'
      check(input, 8, expected)
    end

    it "handles child tags" do
      input = '<div>foo <span>bar</span></div>'
      expected = '<div>foo...</div>'
      check(input, 1, expected)
    end

    it "puts the elllipsis in the right spot with child tags" do
      input = '<div>This <b>is</b> a longer sentence.</div>'
      expected = '<div>This <b>is</b> a...</div>'
      check(input, 3, expected)
    end
  end
end
