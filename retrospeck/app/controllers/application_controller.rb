class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  $sources = ["abc-news-au", "ars-technica", "associated-press", "bbc-news", "bbc-news", "bbc-sport", "bild", "bloomberg", "business-insider", "business-insider-uk", "buzzfeed", "cnbc", "cnn", "daily-mail",
              "der-tagesspiegel", "die-zeit", "engadget", "entertainment-weekly", "espn", "espn-cric-info", "financial-times", "focus", "football-italia", "fortune", "four-four-two", "fox-sports", "google-news",
              "gruenderszene", "hacker-news", "handelsblatt", "ign", "independent", "mashable", "metro", "mirror", "mtv-news", "mtv-new-uk", "national-geographic", "new-scientist", "newsweek", "new-york-magazine", "nfl-news",
              "polygon", "recode", "reddit-r-all", "reuters", "sky-news", "sky-sports-news", "spiegel-online", "t3n", "talksport", "techcrunch", "techradar", "the-economist", "the-guardian-au", "the-guardian-uk", "the-hindu",
              "the-huffington-post", "the-lad-bible", "the-new-yorker", "the-next-web", "the-sport-bible", "the-telegraph", "the-times-of-india", "the-verge", "the-wall-street-journal", "the-washington", "time", "use-today",
              "wired-de", "wirtschafts-woche"]
  $top_100 = ["katyperry", "justinbieber", "taylorswift13", "BarackObama", "rihanna", "ladygaga", "TheEllenShow", "britneyspears", "jtimberlake", "Cristiano", "selenagomez", "jimmyfallon", "ArianaGrande", "shakira", "ddlovato", "Oprah", "JLo", "KingJames",
              "KevinHart4real", "onedirection", "MileyCyrus", "Harry_Styles", "Pink", "Adele", "BrunoMars", "kanyewest", "KAKA", "Pitbull", "ConanOBrien", "davidguetta", "realmadrid", "Louis_Tomlinson", "BeingSalmanKhan", "NICKIMINAJ", "KendallJenner", "zaynmalik",
              "AvrilLavigne", "KylieJenner", "ashkaykumar", "xtina", "RyanSeacrest", "SnoopDogg"]

  $walmart = [54742302, 17448685, 33093101, 46170059, 21293492, 54134701, 48464778, 15162454, 120692442, 45435445, 42338082, 37160038, 17056813, 20690440, 25735986]






require 'twitter'
$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['twitter_key']
  config.consumer_secret = ENV['twitter_secret']
  config.access_token = ENV['twitter_token']
  config.access_token_secret = ENV['twitter_token_secret']
end

#for the use of user authentication for sessions/login
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
