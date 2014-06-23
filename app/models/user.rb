class User < ActiveRecord::Base
  validate :screen_name, :uniqueness => true
  has_many :tweets

  def fetch_tweets!
    tweets = $client.user_timeline(self.screen_name).first(10)

    tweets.each do |t|
      tweet = Tweet.find_by_time(t.created_at) || Tweet.create(:time => t.created_at)
      tweet.text = t.text
      tweet.save
      self.tweets << tweet
    end
  end
end
