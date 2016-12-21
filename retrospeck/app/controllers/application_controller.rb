class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

require 'twitter'
$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['twitter_key']
  config.consumer_secret = ENV['twitter_secret']
  config.access_token = ENV['twitter_token']
  config.access_token_secret = ENV['twitter_token_secret']
end

  protected

    def authenticate_user
      if session[:user_id]
         # set current user object to @current_user object variable
        @current_user = User.find session[:user_id]
        return true
      else
        redirect_to(:controller => 'sessions', :action => 'login')
        return false
      end
    end

    def save_login_state
      if session[:user_id]
        redirect_to(:controller => 'sessions', :action => 'home')
        return false
      else
        return true
      end
    end

  end
