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
      liquid = "{{ '#{input}' | html_truncatewords: 1 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq('foo...')
    end

    it "doesn't count tags as words" do
      Jekyll::HtmlTruncatewords.html_truncatewords('foo')

      input = "<p>foo</p>"
      liquid = "{{ '#{input}' | html_truncatewords: 1 }}"
      output = Liquid::Template.parse(liquid).render()
      expect(output).to eq(input)
    end
  end
end
