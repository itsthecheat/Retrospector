class ReviewsController < ApplicationController
before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]
    def index
      @reviews = Review.all
      @users = User.all
      response = HTTParty.get("https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=#{ENV['news']}", {format: :json})
      @data = response['articles'].sample
      #walmart_api
      @item_num = $walmart
      response = HTTParty.get("http://api.walmartlabs.com/v1/reviews/#{@item_num}?apiKey=#{ENV['walmart']}", {format: :json})
      @walmart = response['reviews'].sample
      # yelp
      params = {term: $yelp_reviews}
      res = Yelp.client.search($cities, params)
      @yelp = res.businesses.sample
      #twitter
      @tweet = $twitter.user_timeline($top_100, count: 2)
    end

    def new
      @reivew = Review.new
      @data1 = params[:data1]
      @data2 = params[:data2]

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
