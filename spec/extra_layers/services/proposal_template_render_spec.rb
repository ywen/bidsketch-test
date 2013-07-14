require 'spec_helper'

module Services
  describe ProposalTemplateRender do
    describe ".render" do
      let(:line1) { "images/blah.png" }
      let(:line2) { %Q|<link href=\"style/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />|}
      let(:line3) { "{proposal_name}" }
      let(:file) { double :file, readlines: [line1, line2, line3]}
      let(:presenter) { double :presenter, name: "a good proposal" }

      let(:result) { described_class.render presenter }

      before(:each) do
        File.stub(:open).and_return file
        AssetsModifier.stub(:perform)
      end

      it "modifies the asset file" do
        AssetsModifier.should_receive(:perform)
        result
      end

      it "replaces the images/blah to assets/blah" do
        expect(result).to include("assets/blah.png")
      end

      it "removes style" do
        expect(result).not_to include(line2)
      end

      it "replace proposal_name" do
        expect(result).to include("a good proposal")
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
