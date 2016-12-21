class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  $yelp_reviews = ["chipotle","ruby-tuesdays","tgi-fridays","wendys","burger-king",
                   "mcdonalds","ninety-nine","applebees","chilis","taco bell","hardees",
                   "long-john-silvers","amys-baking-company","regal-cafe","red-lobsters",
                   "pf-changs","outback","buffalo-wild-wings","bjs-restauraunt-and-brew-house",
                   "red-robin","bonefish","yard-house","arbys","carrabas","maggianos","olive-garden",
                   "cheesecake-factory","the-capital-grill","seasons-52","cracker-barrel","cheddars",
                   "longhorn-steakhouse","texas-roadhosue","auntie-annes","carls-jr","churchs-chicken",
                   "dennys","dean-tai-fung","dominos","dunkin-donuts","earls-kitches","five-guys",
                   "gloria-jeans-coffee","hard-rock-cafe","hooters","ihop","kfc","krispy-kreme",
                   "little-ceasers","panera-bread","papa-johns","pizza-hut","popeyes-chicken","quiznos",
                   "rainforest-cafe","sizzler","starbucks","subway","sweet-frog","tim-hortons",
                   "whataburger","white-castle", 'cannabis'].sample

  $cities = ['New York', 'Orlando', 'Las Vegas', 'New Orleans', 'Denver', 'San Antonio'].sample


  $top_100 = ["katyperry", "justinbieber", "taylorswift13", "BarackObama", "rihanna", "ladygaga", "TheEllenShow", "britneyspears", "jtimberlake", "Cristiano", "selenagomez", "jimmyfallon", "ArianaGrande", "shakira", "ddlovato", "Oprah", "JLo", "KingJames",
              "KevinHart4real", "onedirection", "MileyCyrus", "Harry_Styles", "Pink", "Adele", "BrunoMars", "kanyewest", "KAKA", "Pitbull", "ConanOBrien", "davidguetta", "realmadrid", "Louis_Tomlinson", "BeingSalmanKhan", "NICKIMINAJ", "KendallJenner", "zaynmalik",
              "AvrilLavigne", "KylieJenner", "ashkaykumar", "xtina", "RyanSeacrest", "SnoopDogg"].sample

  $walmart = [54742302, 17448685, 33093101, 46170059, 21293492, 54134701, 48464778, 15162454, 120692442, 45435445, 42338082, 37160038, 17056813, 20690440, 25735986].sample

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
