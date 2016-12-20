class ReviewsController < ApplicationController
    before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]

    def index
      @reviews = Review.all
      @users = User.all
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

    def destroy
      Review.destroy(params[:id])
      redirect_to(:back)
    end

    private
    def user_params
      params.require(:review).permit(:title, :content, :review_link)
    end

end
