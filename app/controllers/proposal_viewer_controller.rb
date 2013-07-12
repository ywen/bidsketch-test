require "#{Rails.root}/app/services/proposal_template_render"
require "#{Rails.root}/app/presenters/proposal_view"
class ProposalViewerController < ApplicationController
  layout false

  def show
    proposal = Proposal.find(params[:id])
    presenter = Presenters::ProposalView.new proposal
    @text = Services::ProposalTemplateRender.render presenter
  end

end
