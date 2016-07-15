class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update]

  def index
    @comment = Comment.order("created_at DESC")
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.user    = current_user
    @comment.post = @post
    if @comment.save
      CommentsMailer.notify_post_owner(@comment).deliver_now
      redirect_to post_path(@post), notice: "comment created"
    else
      render "/posts/show"
    end
  end

  def show
  end

  def edit
    redirect_to root_path, alert: "access defined" unless can? :edit, @comment
  end

  def update
    redirect_to root_path, alert: "access defined" unless can? :update, @comment
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to post_path(@comment.post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    redirect_to root_path, alert: "access defined" unless can? :destroy, @comment
    @comment.destroy
    redirect_to post_path(@post), notice: "comment deleted"
  end

private

  def find_comment
    @comment = Comment.find params[:id]
  end


end
