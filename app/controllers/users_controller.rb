class UsersController < ApplicationController
	def create
		@user_one_friends = Hash.new
		@user_two_friends = Hash.new

		fetch_all_friends(params[:first_user], @user_one_friends)
		fetch_all_friends(params[:second_user], @user_two_friends)
		@common_friends = find_common_friends(@user_one_friends, @user_two_friends)

		render 'users/common_friends'
	end

	private

	def fetch_all_friends(twitter_username, user_hash, max_attempts = 100)
	  # in theory, one failed attempt will occur every 15 minutes, so this could be long-running
	  # with a long list of friends
	  num_attempts = 0
	  client = $client
	  running_count = 0
	  cursor = -1
	  while (cursor != 0) do
	    begin
	      num_attempts += 1
	      # 200 is max, see https://dev.twitter.com/docs/api/1.1/get/friends/list
	      friends = client.friends(twitter_username, {:cursor => cursor, :count => 200} )
	      friends.each do |f|
	        running_count += 1
	        user_hash["#{f.screen_name}"] = ["#{f.name.gsub('"','\"')}","#{f.screen_name}","#{f.url}","#{f.description.gsub('"','\"').gsub(/[\n\r]/," ")}","#{f.profile_image_url}","#{f.profile_banner_url}"]
	      end
	      puts "#{running_count} done"
	      cursor = 0
	      break if cursor == 0
	    rescue Twitter::Error::TooManyRequests => error
	      if num_attempts <= max_attempts
	        p error
	        puts "#{running_count} done from rescue block..."
	        puts "Hit rate limit, sleeping for #{error.rate_limit.reset_in}..."
	        sleep error.rate_limit.reset_in
	        retry
	      else
	        raise
	      end
	    end
	  end
	end

	def find_common_friends(first_hash, second_hash)
	  friends = []
	  friend_objects = []
	  first_hash.each_key do |key|
	    if second_hash.has_key?(key)
	      friends << first_hash[key]
	    end
	  end
	  friends.each do |friend_data|
	  	friend_objects << User.create(:name => friend_data[0], :screen_name => friend_data[1], :url => friend_data[2], :description => friend_data[3], :profile_image_url => friend_data[4], :profile_banner_url => friend_data[5])
	  end
	  friend_objects
	end
end
