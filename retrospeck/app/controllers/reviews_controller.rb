
class ReviewsController < ApplicationController
before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]

    def index

  #variables to generate random params
      @article = $sources.sample
      @rand = $top_100.sample
      @item_num = $walmart.sample

      @reviews = Review.all
      @users = User.all

 #newsapi
      response = HTTParty.get("https://newsapi.org/v1/articles?source=#{@article}&sortBy=top&apiKey=#{ENV['news']}", {format: :json})
      @data = response['articles'][0]
  #walmart_api
      response = HTTParty.get("http://api.walmartlabs.com/v1/reviews/#{@item_num}?apiKey=#{ENV['walmart']}", {format: :json})
      @walm = response['reviews'][0..2]

  #yelp
      res = Yelp.client.business('starbucks-new-york')
      @yelp = res.business.snippet_text

  #twitter
      @tweet = $twitter.user_timeline("#{@rand}", count: 1)
    end

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
      # @review.save

      redirect_to "/reviews"
    end

    def update
      review = params['review']
      Review.update(params[:id],
              title: review[:title],
              content: review[:content],
              user_id: session[:user_id]
              )
  redirect_to "/home"
    end


    def search
      @users = User.all
      @reviews = Review.search(params[:search]).order("created_at DESC")
      flash[:notice] = "We dont have that... or maybe learn 2 spell"

    end


    def destroy
      Review.destroy(params[:id])
      redirect_to(:back)
    end

   def show
    @review = Review.find_by(id: params[:id])
   end

    private
    def user_params
      params.require(:review).permit(:title, :content, :review_link)
    end

end
