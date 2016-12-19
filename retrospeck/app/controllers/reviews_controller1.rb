class ReviewsController < ApplicationController
  def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create
      title = post_params[:title]
      content = post_params[:content]
      slug = post_params[:slug]

      @post = Post.create(
        title: title,
        slug: slug,
        content: content,
        author_id: current_admin_user.id
      )

      redirect_to post_path(@post.slug)
    end

    def edit
      render_not_found unless @post = Post.find_by(slug: params[:id])
    end

    def update
      if post = Post.find_by(slug: params[:id])
        post.update(post_params)
        redirect_to post_path(post_params[:slug])
      else
        redirect_to edit_admin_post_path
      end
    end
end
