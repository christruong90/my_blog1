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
    puts params.inspect
    post_params     = params.require(:post).permit(:title, :body, :tag_ids, :avatar)
    @post           = Post.new post_params
    @post.tag_ids   = params[:post][:tag_ids]
    @post.user      = current_user
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
    @post = Post.friendly.find params[:id]
    post_params = params.require(:post).permit(:title, :body, :tag_ids)
    @post.tag_ids   = params[:post][:tag_ids]
    @post.slug = nil

    if @post.update post_params
      redirect_to post_path(@post), notice: 'post updated!'
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
    @post = Post.friendly.find params[:id]
  end
end
