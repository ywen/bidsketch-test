require 'spec_helper'

describe Presenters::ProposalSection do
  subject { described_class.new model }

  let(:model) { double :model }

  forward_from_model_attributes :id, :description, :name
end
