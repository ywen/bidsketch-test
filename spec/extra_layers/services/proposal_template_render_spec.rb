require 'spec_helper'

module Services
  describe ProposalTemplateRender do
    describe ".render" do
      let(:line1) { "images/blah.png" }
      let(:line2) { "something" }
      let(:file) { double :file, readlines: [line1, line2]}
      let(:presenter) { double :presenter }

      let(:result) { described_class.render presenter }

      before(:each) do
        File.stub(:open).and_return file
      end

      it "replaces the images/blah to assets" do
        expect(result).to include("assets/blah.png")
      end
    end
  end
end
