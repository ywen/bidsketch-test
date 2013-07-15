require 'spec_helper'

describe Services::ProposalSectionRender do
  describe ".render" do
    let(:file_name) { "#{Rails.root}/public/proposal-template/index.html" }

    let(:source) {
      File.open(file_name, "r").readlines.join("\n")
    }

    let(:section1) { double :section1, id: 1, name: "h1", description: "desc1" }
    let(:section2) { double :section2, id: 2, name: "h2", description: "desc2" }
    let(:sections) { [ section1, section2 ] }
    let(:result) { described_class.render(sections, source) }
    let(:html_result) { Nokogiri::HTML.parse result }

    context "with empty sections" do
      let(:sections) { [ ] }

      it "removes the section div" do
        expect(result).not_to include("proposal_section")
      end
    end

    context "with sections" do
      let(:section_1_div) { html_result.at_css("#proposal_section_1") }

      it "inserts the divs with new id" do
        expect(section_1_div).not_to be_nil
        expect(html_result.at("#proposal_section_2")).not_to be_nil
      end

      it "replaces the content" do
        expect(section_1_div.content).to include("h1")
        expect(section_1_div.content).to include("desc1")
      end
    end
  end
end
