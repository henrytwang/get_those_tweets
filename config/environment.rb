# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

$client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'Q6Mn12Nqyv0w8eoFhYsMNFmvn'
  config.consumer_secret = 'sLBrLVDLbSjZcvg95wUkPT70kEywksQcAvfEcb1T7HNdaRgyWZ'
  config.access_token = '16415185-eaxQpZ9E9mrVyn8Nu8HxgVUu2mR0h0U8iPHL36A3W'
  config.access_token_secret = '3NUW0P7Z8iuzNYWU4sErsCZfiCSzplzKX8Jp5zOjuoZL9'
end
