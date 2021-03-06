module Presenters
  class ProposalView
    include ModelPresenter::Base
    forward_from_model :name, :user_name
    has_many :proposal_sections, presenter_class: Presenters::ProposalSection

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

    private

    def client
      @client ||= Client.new(model.client)
    end

  end
end
