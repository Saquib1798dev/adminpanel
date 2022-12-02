class Users::AddressesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:index,  :update]
  before_action :set_default_address, only: [:create, :update]
  before_action :find_address, only: [:show, :update, :destroy]

  def index
    @user_addresses = Address.where(user_id: @user.id)
    render json: {
      message: 'No Address is present'
    } and return unless @user_addresses.present?
    render json: { data: @user_addresses, message: "All Adresses of User" }
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: {data: @address, message: "Address Created Successfully!"}
    else
      render json: { errors: format_activerecord_errors(@address.errors) },
             status: :unprocessable_entity
    end
  end

  def show
    render json: {data: @address, message: "Address Found"}
  end

  def update
    if @address.update(address_params)
      render json: {data: @address, message: "Address Updated Successfully!"}
    else
      render json: { errors: format_activerecord_errors(@address.errors) },
             status: :unprocessable_entity
    end
  end

  def destroy 
    if @address.destroy
      render json: { success: "Address Deleted Successfully" },
             status: :ok
    else
      render json: { errors: "Adress was not deleted" },
      status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.permit(:complete_address, :floor, :latitude, :longitude, :address_type, :default_address, :user_id, :receiver_name, :receiver_phone, :receiver_city, :receiver_pin_code, :receiver_state)
  end

  def set_default_address
    default_address = params[:default_address]
    if default_address?(default_address)
      @user = User.find(params[:user_id])
      addresses = @user.addresses
      addresses.update_all(default_address: false)
    end
  end

  def default_address?(default)
    if default == "true"
      true
    else
      false
    end
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_address
    @address = Address.find(params[:id])
  end

end
