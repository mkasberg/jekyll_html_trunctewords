require 'spec_helper'

RSpec.describe JekyllHtmlTruncatewords do
  it "has a version number" do
    expect(JekyllHtmlTruncatewords::VERSION).not_to be nil
  end

  it "works as a Liquid template" do
    input = "<p>This is a sentence with more than 5 words.</p>"
    liquid = "{{ '#{input}' | html_truncatewords: 5, '~!' }}"
    output = Liquid::Template.parse(liquid).render()
    expect(output).to eq('<p>This is a sentence with~!</p>')
  end

  context 'examples' do
    def check(input, words, expected)
      output = JekyllHtmlTruncatewords.html_truncatewords(input, words)
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

    it "truncates child tags correctly" do
      input = '<div>This <b>is</b> a longer sentence.</div>'
      expected = '<div>This <b>is</b> a...</div>'
      check(input, 3, expected)
    end

    it "truncates child tags and following nodes in parent tags" do
      input = '<p>This is a <i>really <b>nested</b></i> sentence structure.</p>'
      expected = '<p>This is a <i>really <b>nested...</b></i></p>'
      check(input, 5, expected)
    end

    it "Doesn't count images as words" do
      input = '<img src="https://jekyllrb.com/img/logo-2x.png"> The Jekyll logo!'
      check(input, 3, input)
    end

    it "Truncates text after an image" do
      input = '<img src="https://jekyllrb.com/img/logo-2x.png"> The Jekyll logo!'
      expected = '<img src="https://jekyllrb.com/img/logo-2x.png"> The Jekyll...'
      check(input, 2, expected)
    end
  end
end
