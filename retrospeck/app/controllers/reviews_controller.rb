class ReviewsController < ApplicationController
    before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]
    def new
      @reivew = Review.new
    end

    #For the post method on the new page form
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

    #Fix because this is like some hybrid version of 4/5
    private
    def user_params
      params.require(:review).permit(:title, :content, :review_link)
    end
  end
