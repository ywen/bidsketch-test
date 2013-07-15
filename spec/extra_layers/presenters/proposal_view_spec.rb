require 'spec_helper'

module Presenters
  describe ProposalView do
    let(:send_date) { "2013-07-10".to_date }
    let(:client) { double :client, name: 'client', company: "company", website: "website" }
    let(:model) { double :model, send_date: send_date, client: client }

    subject { described_class.new model }

    forward_from_model_attributes :name, :user_name

    describe "#formatted_send_date" do
      it "returns formatted send date time" do
        expect(subject.formatted_send_date).to eq("July 10, 2013")
      end
    end

    class << self
      def it_delegates_from_client(*attrs)
        attrs.each do |attr|
          it "delegates from client for #{attr}" do
            expect(subject.send("client_#{attr}")).to eq(client.send(attr))
          end
        end
      end
    end

    it_delegates_from_client :name, :company, :website

    describe "#proposal_sections" do
      let(:proposal_section1) { double :proposal_section1 }
      let(:proposal_section2) { double :proposal_section2 }

      before(:each) do
        model.stub(:proposal_sections).and_return [proposal_section1, proposal_section2]
      end

      it "returns an array of proposal_sections" do
        expect(subject.proposal_sections.size).to eq(2)
      end

      it "returns them as Presenter" do
        expect(subject.proposal_sections[0]).to be_a(Presenters::ProposalSection)
      end
    end
  end
end
