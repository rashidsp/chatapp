class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.search_users(params[:keywords].to_s).except_user(current_user)
  end

  def friendship_exists
    contact = User.where(id: params[:contact_id]).first
    is_friend = contact.present? ? current_user.is_friend?(contact) : false
    render json: {success: is_friend}
  end

end
