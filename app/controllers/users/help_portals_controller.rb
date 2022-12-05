class Users::HelpPortalsController < ApplicationController

  def index
    @help = HelpPortal.all
    render json: {data: @help, succss: true }
  end

end
