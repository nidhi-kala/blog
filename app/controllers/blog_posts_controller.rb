class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_blog_post, except: [ :new, :create, :index ]
  def index
    @posts = BlogPost.all
  end

  def show
  end

  def new
    @post = BlogPost.new
  end

  def create
    @post = BlogPost.new(blog_post_params)
    if @post.save
      redirect_to @post, notice: "created"
    else
      render :new, status: :unprocessable_entity
      Rails.logger.debug @post.errors.full_messages
    end
  end

  def edit
  end

  def update
    if @post.update(blog_post_params)
      redirect_to @post, notice: "updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
  def blog_post_params
    params.require(:blog_post).permit([ :title, :body ])
  end

  def set_blog_post
    @post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end
end
