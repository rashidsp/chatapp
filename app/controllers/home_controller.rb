class HomeController < ApplicationController
  def index
  end

  def validate_email
  	user = User.where(email: params[:email]).first
  	render json: {
  		success: user.present?, 
  		message: user.present? ? "" : "Email does not belongs to any user!"
  	}
  end
end
