require 'spec_helper'

module Services
  describe ProposalTemplateRender do
    describe ".render" do
      let(:line1) { "images/blah.png" }
      let(:line2) { %Q|<link href=\"style/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />|}
      let(:line3) { "{proposal_name}" }
      let(:file) { double :file, readlines: [line1, line2, line3]}
      let(:presenter_messages) {
        {
          name: "a proposal",
          formatted_send_date: "July 12, 2013",
          client_name: "a client",
          user_name: "a proposal user",
          client_company: "client company",
          client_website: "client website",
          proposal_sections: ["1", "2"]
        }
      }
      let(:presenter) { double :presenter, presenter_messages }

      let(:result) { described_class.render presenter }

      before(:each) do
        File.stub(:open).and_return file
        AssetsModifier.stub(:perform)
        ProposalSectionRender.stub(:render).and_return "text"
      end

      it "renders sections" do
        ProposalSectionRender.should_receive(:render).with(%w(1 2), anything)
        result
      end

      it "modifies the asset file" do
        AssetsModifier.should_receive(:perform)
        result
      end

      it "replaces the images/blah to assets/blah" do
        ProposalSectionRender.stub(:render).and_return "images/blah.png"
        expect(result).to include("assets/blah.png")
      end

      it "removes style" do
        expect(result).not_to include(line2)
      end

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
              ProposalSectionRender.stub(:render).and_return("{#{template_attr_name}}")
              presenter.stub(name).and_return "some #{name}"
              expect(result).to include("some #{name}")
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
