require 'spec_helper'

describe ProposalViewerController do
  describe "GET#show" do
    it "renders show" do
      get :show, id: 12
      expect(response).to render_template("show")
    end
  end
end
