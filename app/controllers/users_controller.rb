class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.search_users(params[:keywords].to_s).except_user(current_user)
  end

end
