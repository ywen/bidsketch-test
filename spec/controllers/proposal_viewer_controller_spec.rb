require 'spec_helper'

describe ProposalViewerController do
  describe "GET#show" do

    it "finds the proposal" do
    end

    it "initializes a presenter" do
    end

    it "renders the view" do
      get :show, id: 12
      expect(response).to render_template("show")
    end
  end
end
