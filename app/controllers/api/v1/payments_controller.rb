module Api
  module V1
    class PaymentsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_order_params, only: %i[create_order]
      before_action :get_user, only: %i[create_order show_order]

      def create_order
        payment = Razorpay::Order.create amount: @amount, currency: @currency, receipt: @receipt
        if payment.attributes["status"] == "created"
          cart = Cart.find_by_id(@user.cart.id)
          order = Order.create(cart_id: cart.id, status: "completed", order_amount:  payment.attributes["amount"], order_date: Date.today, order_number:  rand.to_s[2..11], payment_order_id: payment.attributes["id"])
          # cart.line_items.delete_all
          render json: {data: order, succes: true}
        end
      end

      def show_order
        @cart = @user.cart
        @order = Order.find_by_id(params[:order_id])
      end

      # def verify_payment_state
      # end

      private 

      def set_order_params
        @amount = params[:amount]
        @currency = params[:currency]
        @receipt = params[:receipt]
      end

      def get_user
        @user = User.find(params[:user_id])
      end
    end
  end
end