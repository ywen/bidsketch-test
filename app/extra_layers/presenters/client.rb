module Presenters
  class Client
    include ModelPresenter::Base
    forward_from_model :name, :company, :website
  end
end
