class ReviewsController < ApplicationController
    before_filter :authenticate_user, :only => [:home, :profile, :setting, :new]

    def index
        @posts = Review.all
      end

      def new
        @post = Review.new
      end

      def create
        title = post_params[:title]
        content = post_params[:content]

        @post = Review.create(
          title: title,
          content: content,
          author_id: current_admin_user.id
        )

        redirect_to post_path(@post.slug)
      end

      def edit
        render_not_found unless @post = Review.find_by(title: params[:id])
      end

      # def update
      #   if post = Post.find_by(slug: params[:id])
      #     post.update(post_params)
      #     redirect_to post_path(post_params[:slug])
      #   else
      #     redirect_to edit_admin_post_path
      #   end
      # enda
  end
