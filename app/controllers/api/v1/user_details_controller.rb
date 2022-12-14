module Api
  module V1
    class UserDetailsController < ApplicationController
      # before_action :authenticate
      skip_before_action :verify_authenticity_token
      before_action :get_user
      before_action :get_complete_image_url, only: [:show, :update]
      before_action :update_type_field, only: [:generate_otp]
      before_action :compare_current_password, only: [:change_password]

      def show
        render json: { data: @user, avatar: @complete_image_url }
      end

      def update
        @user.update(user_params)
        render json: { data: @user, avatar:  @complete_image_url  }
      end

      def verify_otp
        otp = @user.otps.where(["otp_type = ?", "#{params[:user][:type]}"]).first
        if otp.present?
          if update_email_or_phone_number(@user, otp)
            if otp.update(otp_verified: true)
              render json: {otp_data: otp, data: @user, message: "Otp has been verified and the field has been updated", success: true}, status: :ok
            end
          else
            render json: {message: "Email or Phone number was not updated", status: false}, status: :unprocessable_entity
          end 
        else
          render json: {message: "Incorrect Otp no field updated", status: false }, status: :unprocessable_entity
        end
      end

      def destroy
      end

      def generate_otp
        render json: {data: @user, otp: @user.otps,  message: "Otp for updation ", success: true}
      end

      def change_password
        if @equal
          new_password = params[:user][:new_password]
          if @user.update(password: new_password)
            render json: { data: @user, message: "Password Updated", success: true}, status: :ok
          else
            render json: { data: @user, message: "Password Not Updated", success: false}, status: :unprocessable_entity
          end
        else
          render json: {message: "Incorrect Current Password", success: false}, status: :unprocessable_entity
        end
      end

      private

      def update_type_field
        if params[:user][:update_type] == "email_update" || params[:user][:update_type_two] == "email_update"
          @otp = @user.otps.where(otp_type: "email_update").first
          if @otp.present?
            @otp.update(otp_digits: 1111, otp_verified: false, otp_token: 1234)
          else
            type = "email_update"
           @otp =  create_otp(@user, type)
          end 
        elsif params[:user][:update_type] == "phone_update" || params[:user][:update_type_two] == "phone_update"
          @otp = @user.otps.where(otp_type: "phone_update").first
          if @otp.present?
            @otp.update(otp_digits: 1111, otp_verified: false, otp_token: 1234)
          else
            type = "phone_update"
            @otp = create_otp(@user, type)
          end 
        end
      end

      def compare_current_password
        current_password = params[:user][:current_password]
        if @user.valid_password?(current_password)
          @equal  = true 
        else
          @equal = false
        end
      end

      def user_params
        params.permit(:full_name, :avatar)
      end

      def update_email_or_phone_number(user, otp)
        if otp.otp_type == "email_update"
          user.update(email: params[:user][:email])
        elsif otp.otp_type == "phone_update"
          user.update(full_phone_number: params[:user][:full_phone_number])
        end
      end

      def get_complete_image_url
        if @user.avatar.present?
          # @base_url = "#{request.protocol}#{request.host_with_port}"
          @complete_image_url = @user.avatar.service_url
        end 
      end

      def create_otp(user, type)
        @otp = user.otps.create(otp_digits: 1111, otp_type: type, otp_verified: false, otp_token: 1234)
      end

      def get_user
        @user = User.find(params[:id])
      end

      # def authenticate
      #   render json: { message: "Token Not present", success: false } and return if request.headers['authorization'].blank?
      #   begin
      #     data = JWT.decode(request.headers['authorization'].split(' ').last,"", false)
      #   rescue StandardError => e
      #     return render json: {message: "Invalid Token", success: false }
      #   else
      #     exp_time = Time.at(data[0]["exp"])
      #     user = User.find(data[0]["sub"])
      #     unless Time.now < exp_time
      #       return  render json: { message: "Token Expired", success: false }
      #     end
      #   end 
      # end
    end
  end
end
