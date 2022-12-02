module Api
  module V1
    class ItemsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :get_item, only: [:show]
      

      def index
        @items = FilterItemService.call(params[:search])
        @items = @items.order("#{sort_column} #{sort_direction}")
      end

      def show
      end

      private 

      def sort_column
        Item.column_names.include?(params[:sort_by]) ? params[:sort_by] : "name"
      end

      def sort_direction
        if %w(asc desc).include?(params[:direction])
          params[:direction]
        else
          "asc"
        end
      end

      def get_item
        @item = Item.find(params[:id])
      end

    end
  end
end
