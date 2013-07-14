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
  end
end
