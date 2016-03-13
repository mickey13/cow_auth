module CowAuth
  module Authentication
    extend ActiveSupport::Concern
    include ActionController::HttpAuthentication::Token::ControllerMethods

  private

    def authenticate_user
      authenticate_or_request_with_http_token do |api_key, options|
        sid, auth_token = api_key.match(/sid=([[:alnum:]]*)&auth_token=([[:alnum:]]*)/).try(:captures)
        @current_user = User.authenticate_from_token(sid, auth_token)
      end
    end
  end
end