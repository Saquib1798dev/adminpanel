require 'httparty'                                                             
require 'json'
module Api
  module V1
    class SocialMediaUsersController < ApplicationController
      # before_action :authenticate_user!
      #here the token ids which are fetched from front end and passed and the information is retrieved from the get url
      def google_oauth2
        url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["token_id"]}"                  
        response = HTTParty.get(url)
        response = SocialMediaUser.create_user_for_google(response.parsed_response, params[:name])
        if response[:check] 
          render json: {success: true, data: response[:data] }
        end 
      end
    end
  end
end
