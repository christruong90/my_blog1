class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.new post_params
    @post.user    = current_user
      if @post.save
        redirect_to post_path(@post)
      else
        render :new
      end
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def edit
    redirect_to root_path, alert: "access defined" unless can? :edit, @post
  end

  def update
    post_params = params.require(:post).permit(:title, :body)
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end



  private

  def authorize_owner
      redirect_to root_path, alert: "access denied" unless can? :manage, @post
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
  end

  def find_post
    @post = Post.find params[:id]
  end
end
