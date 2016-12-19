class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
require 'twitter'
$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['twitter_key']
  config.consumer_secret = ENV['twitter_secret']
  config.access_token = ENV['twitter_token']
  config.access_token_secret = ENV['twitter_token_secret']
end
end
