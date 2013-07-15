require 'spec_helper'

module Services
  describe ProposalTemplateRender do
    describe ".render" do
      let(:sections) { double :sections }
      let(:presenter) { double :presenter, proposal_sections: sections}
      let(:result) { described_class.render presenter }

      before(:each) do
        FileOperation.stub(:read).and_return "text1"
        AssetsModifier.stub(:perform)
        StylesheetLinkModifier.stub(:perform).and_return "text2"
        ProposalRender.stub(:render).and_return "text3"
        Services::ProposalSectionRender.stub(:render).and_return "text4"
      end

      it "reads the index file" do
        FileOperation.should_receive(:read).with(FileOperation.html_file).and_return "text1"
        result
      end

      it "modifies the asset file" do
        AssetsModifier.should_receive(:perform)
        result
      end

      it "fixes the stylesheet link" do
        text = StylesheetLinkModifier.should_receive(:perform).with("text1").and_return "text2"
        result
      end

      it "propagate the proposal information" do
        ProposalRender.should_receive(:render).with(presenter, "text2").and_return "text3"
        result
      end

      it "propagate section info" do
        Services::ProposalSectionRender.should_receive(:render).with(sections, "text3")
        result
      end
    end
  end

  describe ProposalRender do
    let(:presenter_messages) {
      {
        name: "a proposal",
        formatted_send_date: "July 12, 2013",
        client_name: "a client",
        user_name: "a proposal user",
        client_company: "client company",
        client_website: "client website"
      }
    }
    let(:presenter) { double :presenter, presenter_messages }
    let(:result) { described_class.perform presenter, text }

    class << self
      def it_replaces(template_attr_name)
        ItReplaces.new(self, template_attr_name)
      end

      class ItReplaces
        def initialize(example_group, template_attr_name)
          @example_group = example_group
          @template_attr_name = template_attr_name
        end

        def with(name)
          template_attr_name = @template_attr_name
          @example_group.it "replaces #{template_attr_name} with #{name}" do
            presenter.stub(name).and_return "some #{name}"
            expect(described_class.render presenter, "{#{template_attr_name}}").to include("some #{name}")
          end
        end
      end
    end

    it_replaces(:proposal_name).with(:name)
    it_replaces(:proposal_send_date).with(:formatted_send_date)
    it_replaces(:client_name).with(:client_name)
    it_replaces(:proposal_user_name).with(:user_name)
    it_replaces(:client_company).with(:client_company)
    it_replaces(:client_website).with(:client_website)

  end

  describe StylesheetLinkModifier do
    describe ".perform" do
      let(:line2) { %Q|<link href=\"style/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />|}
      let(:text) { "images/blah.png\n#{line2}"}
      let(:result) { described_class.perform text }

      it "replaces the images/blah to assets/blah" do
        expect(result).to include("assets/blah.png")
      end

      it "removes style" do
        expect(result).not_to include(line2)
      end

    end
  end

  describe AssetsModifier do
    describe ".perform" do
      let(:destination_path) { "#{Rails.root}/public/copied-stylesheets/style.css"}
      let(:result) { File.open(destination_path, "r").readlines.join("\n") }

      after(:each) do
        FileUtils.rm destination_path
      end

      it "copies file from the default position to public/copied-stylesheets" do
        described_class.perform
        expect(File).to be_exists(destination_path)
      end

      it "replaces all from ../images to /assets" do
        described_class.perform
        expect(result).not_to include("../images")
        expect(result).to include("/assets")
      end

    end
  end
end
