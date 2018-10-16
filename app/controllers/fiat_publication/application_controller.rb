module FiatPublication
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # include SetCurrentPublisher
  end
end
