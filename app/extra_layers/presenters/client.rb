module Presenters
  class Client
    include ModelPresenter::Base
    forward_from_model :name
  end
end
