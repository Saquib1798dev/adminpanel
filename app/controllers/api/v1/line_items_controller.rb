# frozen_string_literal: true

module Api
  module V1
    # line items request
    class LineItemsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_line_item, only: %i[add_quantity reduce_quantity]
      before_action :find_item_cart, only: %i[create]

      def create
        if @cart.items.include?(@selected_item)
          @line_item = @cart.line_items.find_by(item_id: @selected_item)
          @line_item.quantity += 1
        else
          @line_item = LineItem.new
          @line_item.cart = @cart
          @line_item.item = @selected_item
        end
        return unless @line_item.save

        render json: {data: @line_item, success: true}
      end

      def add_quantity
        @line_item.quantity += 1

        return unless @line_item.save

        render json: { success: true, data: @line_item, message: 'Items added in cart' }
      end

      def reduce_quantity
        @line_item.quantity -= 1 if @line_item.quantity > 1

        return unless @line_item.save

        render json: { success: true, data: @line_item, message: 'Items removed from cart' }
      end

      private

      def find_item_cart
        @selected_item = Item.find(params[:item_id])
        @cart = Cart.find(params[:cart_id])
      end

      def find_line_item
        @line_item = LineItem.find(params[:id])
      end
    end
  end
end
