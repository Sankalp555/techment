class TweetsController < ApplicationController
  before_action :authenticate_user!
  

  def index
    followers_ids = current_user.following.pluck(:id)
    if followers_ids.present?
      if params[:tweet][:order] == 'desc'
        @tweets = Tweet.where(user_id: followers_ids).order("created_at DESC")
      else
        @tweets = Tweet.where(user_id: followers_ids).order("created_at ASC")
      end
    else
      render json: {error: 'You did not follow anyone to get some tweets. Please follow someone.'}
      return
    end
  end

  def create
    if params[:tweet][:message].blank?
      render json: {error: 'Please proivde valid parameters'}
      return
    end
    tweet = current_user.tweets.create(message: params[:tweet][:message])
    render json: {id: tweet.id, message: tweet.message}
  end
end