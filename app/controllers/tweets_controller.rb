class TweetsController < ApplicationController
	def create
	puts "$$$$$ " + params[:handle]
    @user = User.find_by_name(params[:handle]) || User.create(:screen_name => params[:handle])
    @tweets = @user.fetch_tweets!
    # user.fetch_friends!
    render 'tweets/user_tweets'
	end
end
