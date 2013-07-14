require 'spec_helper'

describe Presenters::Client do
  let(:model) { double :model }

  subject { described_class.new model }

  forward_from_model_attributes :name
end
