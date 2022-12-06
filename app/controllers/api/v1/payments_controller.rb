module Api
  module V1
    class PaymentsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_order_params, only: %i[create_order]
      before_action :get_user, only: %i[create_order show_order index]

      def create_order
        payment = Razorpay::Order.create amount: @amount, currency: @currency, receipt: @receipt
        if payment.attributes["status"] == "created"
          cart = Cart.find_by_id(@user.cart.id)
          order = Order.create(cart_id: cart.id, status: "completed", order_amount:  payment.attributes["amount"], order_date: Date.today, order_number:  rand.to_s[2..11], payment_order_id: payment.attributes["id"])
          items = cart.line_items
          items = JSON.parse(items.to_json)
          if create_order_summary(order, @user, items, request)
            cart&.line_items&.delete_all
          end
          render json: {data: order, succes: true}
        end
      end

      def show_order
        @cart = @user.cart
        @order = Order.find_by_id(params[:order_id])
      end

      def index
        orders = @user.cart.orders
        render json: {data: orders, success: true}
      end

      # def verify_payment_state
      # end

      private

      def set_order_params
        @amount = params[:amount]
        @currency = params[:currency]
        @receipt = params[:receipt]
      end

      def create_order_summary(order, user, products, request)
        products.map do |product|
          item = Item.find_by_id(product["item_id"])
          product["item_image"] = nil
          product["item_image"] = item.images_url("#{request.protocol}#{request.host_with_port}") if item.item_image.present?
          product["name"] = item.name
          product["quantity"] = product["quantity"]
        end
        order_summary = {order: order, items: products}
        order_summary = JSON.parse(order_summary.to_json)
        order.update(order_summary: order_summary)
        return true
      end

      def get_user
        @user = User.find(params[:user_id])
      end
    end
  end
end