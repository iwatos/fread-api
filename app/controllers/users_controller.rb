class UsersController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate
    def authenticate
        authenticate_or_request_with_http_token do |token,options|
            token == ENV.fetch('FREAD_TOKEN')
        end
    end
  
    def index
        render json: { status: 'SUCCESS'}
    end
end
