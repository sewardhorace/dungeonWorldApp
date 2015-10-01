module Api
  module V1
    class InvalidGoogleParamsError < StandardError; end
    class ApiController < ActionController::Base
      respond_to :json

    end
  end
end
