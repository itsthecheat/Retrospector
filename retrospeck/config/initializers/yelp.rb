require 'yelp'

  client = Yelp::Client.new({
                              consumer_key = ENV['yelp_key'],
                              consumer_secret = ENV['yelp_secret'],
                              token = ENV['yelp_token'],
                              token_secret = ENV['yelp_token_secret']
                              })


