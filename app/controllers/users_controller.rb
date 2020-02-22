class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def profile
    @following = current_user.following
    @followers = current_user.followers
  end
end