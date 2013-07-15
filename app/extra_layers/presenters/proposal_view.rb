module Presenters
  class ProposalView
    include ModelPresenter::Base
    forward_from_model :name, :user_name

    def formatted_send_date
      model.send_date.strftime("%B %d, %Y")
    end

    def client_name
      client.name
    end

    def client_company
      client.company
    end

    def client_website
      client.website
    end

    def proposal_sections
      model.proposal_sections.map{|s| Presenters::ProposalSection.new(s) }
    end

    private

    def client
      @client ||= Client.new(model.client)
    end

  end
end
