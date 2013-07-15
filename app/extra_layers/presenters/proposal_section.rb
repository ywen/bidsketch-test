module Presenters
  class ProposalSection
    include ModelPresenter::Base
    forward_from_model :id, :description, :name
  end
end
