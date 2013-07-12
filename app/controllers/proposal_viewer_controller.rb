require "#{Rails.root}/app/services/proposal_template_render"
class ProposalViewerController < ApplicationController
  layout false

  def show
    text = Services::ProposalTemplateRender.render
    render html: text
  end

end
