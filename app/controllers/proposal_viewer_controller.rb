class ProposalViewerController < ApplicationController
  layout false

  def show
    template = "#{Rails.root}/public/proposal-template/index.html"
    render file: template
  end

end
