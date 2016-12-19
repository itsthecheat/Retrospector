class ReviewsController < ApplicationController
<<<<<<< HEAD

  def index
  #news_api
  response = HTTParty.get('https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=d7bd4c29053c495c9845714ee487f096', {format: :json})
  @data = response['articles'][0]
  # yelp
  params = {term: 'starbucks'}
  res = Yelp.client.search('New York', params)
  @yelp = res.businesses[0].snippet_text
  #twitter
  @tweet = $twitter.user_timeline("realdonaldtrump", count: 10)
  end

end
=======
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
>>>>>>> 0e63e8d09ca60adfd4602e6672ab9b2b14471937
