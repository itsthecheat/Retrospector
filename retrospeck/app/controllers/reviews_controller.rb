class ReviewsController < ApplicationController


  def index
    response = HTTParty.get("https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=#{ENV['news']}", {format: :json})
    @data = response['articles'][0]
    #walmart_api
    response = HTTParty.get("http://api.walmartlabs.com/v1/reviews/33093101?apiKey=#{ENV['walmart']}", {format: :json})
    @walm = response
    # yelp
    params = {term: 'starbucks'}
    res = Yelp.client.search('New York', params)
    @yelp = res.businesses[0].snippet_text
    #twitter
    @tweet = $twitter.user_timeline("realdonaldtrump", count: 10)
  end

   before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]

   def new
     @reivew = Review.new
   end

   def create
       title = user_params[:title]
       content = user_params[:content]
       review_link = user_params[:review_link]
     @review = Review.create(
       title: title,
       content: content,
       review_link: review_link,
       user_id: session[:user_id])
     @review.save

     redirect_to "/reviews/new"
   end

   private

   def user_params
     params.require(:review).permit(:title, :content, :review_link)
   end

 end


