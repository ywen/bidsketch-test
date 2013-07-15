module Services
  class ProposalSectionRender
    class << self
      def render(sections, source)
        html = Nokogiri::HTML.parse source
        section_html = html.at_css("#proposal_section")
        sections.each do |section|
          new_html = section_html.dup
          new_html["id"] = "proposal_section_#{section.id}"
          h1 = new_html.at_css("h1")
          h1.content = section.name
          content_div = new_html.at_css("div")
          content_div.content = section.description
          section_html.add_previous_sibling(new_html)
        end
        section_html.remove
        html.to_html
      end
    end
  end
end
