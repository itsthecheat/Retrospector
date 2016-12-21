class ReviewsController < ApplicationController
before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]
    def index
      @reviews = Review.all
      @users = User.all
      # response = HTTParty.get("https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=#{ENV['news']}", {format: :json})
      # @data = response['articles'][0]
      # #walmart_api
      # response = HTTParty.get("http://api.walmartlabs.com/v1/reviews/33093101?apiKey=#{ENV['walmart']}", {format: :json})
      # @walm = response['reviews']
      # yelp
      yelp_reviews = ["chipotle","ruby-tuesdays","tgi-fridays","wendys","burger-king",
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
      cities = ['New York', 'Orlando', 'Las Vegas', 'New Orleans', 'Denver', 'San Antonio'].sample
      params = {term: yelp_reviews}
      res = Yelp.client.search(cities, params)
      @yelp = res.businesses.sample

      # res = Yelp.client.business('republic-new-york')
      # @yelp = res.business.snippet_text
      # #twitter
      # @tweet = $twitter.user_timeline("realdonaldtrump", count: 10)
    end

    def new
      @review = Review.new
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

    def show
      @review = Review.find_by(id: params[:id])
    end

    def destroy
      Review.destroy(params[:id])
      redirect_to(:back)
    end

    private
    def user_params
      params.require(:review).permit(:title, :content, :review_link)
    end

end
