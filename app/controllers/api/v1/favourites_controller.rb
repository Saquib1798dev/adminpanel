module Api
  module V1
    class FavouritesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :get_user, only: [:add, :list]
      before_action :get_favourite, only: [:remove]


      def add
        favourite = Favourite.find_or_create_by(user_id: @user.id)
        item = Item.find_by_id(params[:item_id])
        unless item.nil?
          if favourite.item_ids.include?(item.id)
            render :json => 'item already in the wishlist'
          else
            favourite.items << item
            render json: {data: favourite, success: true}
          end
        end
      end

      def remove
        item = Item.find_by_id(params[:item_id])
        unless item.nil?
          if @favourite.item_ids.include?(item.id)
            @favourite.item_ids = @favourite.item_ids - [item.id]
            render json: {success: true, message: "Item Removed from wishlist"}
          else
            render json: {success: false, message: "No item is present in the wishlist"}
          end 
        end
      end

      def list
        items = @user.favourite,items
        render json: {data: items, success: :true }
      end

      def get_favourite
        @favourite = Favourite.find_by_id(params[:favourite_id])
      end

      # def user_favourites
      #   favourites = @user.favourites
      #   render json: {success: true, favourites: favourites }
      # end

      private

      def get_user
        @user = User.find(params[:user_id])
      end
      
    end
  end
end