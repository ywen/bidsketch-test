require 'spec_helper'

describe ProposalViewerController do
  describe "GET#show" do
    let(:proposal) { double :proposal }
    let(:presenter) { double :presenter }

    before(:each) do
      Proposal.stub(:find).and_return proposal
      Presenters::ProposalView.stub(:new).and_return presenter
      Services::ProposalTemplateRender.stub(:render).and_return "<html></html>"
    end

    it "finds the proposal" do
      Proposal.should_receive(:find).with("12").and_return proposal
      get :show, id: 12
    end

    it "initializes a presenter" do
      Presenters::ProposalView.should_receive(:new).with(proposal).and_return presenter
      get :show, id: 12
    end

    it "asks the service to render" do
      Services::ProposalTemplateRender.should_receive(:render).with(presenter).and_return "text"
      get :show, id: 12
    end

    it "assigns the rendering result" do
      get :show, id: 12
      expect(assigns[:text]).to eq("<html></html>")
    end
  end
end
