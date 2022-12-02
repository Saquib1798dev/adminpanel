module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :get_category, only: [:show]
      skip_before_action :verify_authenticity_token

      def index
        @categories = Category.all.order("#{sort_column} #{sort_direction}")
        render json: {data: @categories, success: true}
      end

      def show
        render json:{data: @category, success: true}
      end

      private 

      def sort_column
        Category.column_names.include?(params[:sort_by]) ? params[:sort_by] : "name"
      end

      def sort_direction
        if %w(asc desc).include?(params[:direction])
          params[:direction]
        else
          "asc"
        end
      end

      def get_category
        @category = Category.find(params[:id])
      end
    end
  end
end
