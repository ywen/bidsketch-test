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

    private

    def client
      Client.new(model.client)
    end

  end
end
