class TweetsController < ApplicationController
	def create
	    @user = User.find_by_name(params[:handle]) || User.create(:screen_name => params[:handle])
	    @tweets = @user.fetch_tweets!
	    render 'tweets/user_tweets'
	end
end
