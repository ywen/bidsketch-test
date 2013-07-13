module Presenters
  class ProposalView
    include ModelPresenter::Base
    forward_from_model :name

  end
end
