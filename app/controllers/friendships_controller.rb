class FriendshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @request = current_user.friendships.new(friend_id: params[:user_id])
    if @request.save
      render json: {success: true, friend_id: @request.friend_id, message: "friend request sent."}
    else
      render json: {success: false, message: @request.errors.full_messages.first}
    end
  end
end
