require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = ENV['yelp_key']
  config.consumer_secret = ENV['yelp_secret']
  config.token = ENV['yelp_token']
  config.token_secret = ENV['yelp_token_secret']
end
