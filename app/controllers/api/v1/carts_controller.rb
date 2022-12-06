# frozen_string_literal: true

module Api
  module V1
    # cart actions for show and destroy
    class CartsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_cart, only: %i[show destroy_line_item]
      before_action :find_user, only: %i[create]

      def create
        unless @user.cart.present?
          @user.build_cart.save!
        else
        end
        render json: {success: true, data: @user.cart}
      end

      def show
        unless @user.cart.present?
          render json: { success: true, message: 'Cart is not present please create' }
        else
        end
      end

      # def destroy_line_item
      #   debugger
      #   @user.cart.line_items.find_by_id(params[:line_id]).destroy!
      #   render json: { success: true, message: 'Product Deleted' }
      # end

      private

      def find_cart
        @user = User.find(params[:id])
      end

      def find_user
        @user = User.find(params[:user_id])
      end

      # end of private
    end
  end
end
