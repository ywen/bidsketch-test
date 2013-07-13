require 'spec_helper'

module Presenters
  describe ProposalView do
    let(:model) { double :model }
    subject { described_class.new model }

    forward_from_model_attributes :name
  end
end
