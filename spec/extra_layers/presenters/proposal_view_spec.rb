require 'spec_helper'

module Presenters
  describe ProposalView do
    let(:send_date) { "2013-07-10".to_date }
    let(:model) { double :model, send_date: send_date }

    subject { described_class.new model }

    forward_from_model_attributes :name, :user_name

    describe "#formatted_send_date" do
      it "returns formatted send date time" do
        expect(subject.formatted_send_date).to eq("July 10, 2013")
      end
    end
  end
end
