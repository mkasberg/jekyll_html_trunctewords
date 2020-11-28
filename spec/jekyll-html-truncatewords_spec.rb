require 'spec_helper'

RSpec.describe Jekyll::HtmlTruncatewords do
  it "has a version number" do
    expect(Jekyll::HtmlTruncatewords::VERSION).not_to be nil
  end

  context 'examples' do
    it "doesn't change input under limit with no HTML" do
      input = "foo bar"
      liquid = "{{ '#{input}' | html_truncatewords: 10 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq(input)
    end

    it "truncates words to the limit" do
      input = 'foo bar'
      output = Jekyll::HtmlTruncatewords.html_truncatewords(input, 1)
      expect(output).to eq('foo...')
    end

    it "doesn't count tags as words" do
      input = "<p>foo</p>"
      Jekyll::HtmlTruncatewords.html_truncatewords(input)
      liquid = "{{ '#{input}' | html_truncatewords: 1 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq(input)
    end

    it "truncates text inside a single tag" do
      input = "<p>This is a sentence with more than 5 words.</p>"
      Jekyll::HtmlTruncatewords.html_truncatewords(input, 5)
      liquid = "{{ '#{input}' | html_truncatewords: 5 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq('<p>This is a sentence with...</p>')
    end

    it "handles sibling tags" do
      input = "<p>foo</p><p>bar</p>"
      Jekyll::HtmlTruncatewords.html_truncatewords(input, 10)
      liquid = "{{ '#{input}' | html_truncatewords: 10 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq(input)
    end

    it "handles child tags" do
      input = "<div>foo <span>bar</span></div>"
      Jekyll::HtmlTruncatewords.html_truncatewords(input, 1)
      liquid = "{{ '#{input}' | html_truncatewords: 1 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq("<div>foo...</div>")
    end
  end
end
