class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update]

  def index
    @comment = Comment.order("created_at DESC")
  end

  def new
    @comment = Comment.new
  end

  def create
    @post             = Post.find_by_title params[:post_id]
    comment_params    = params.require(:comment).permit(:body)
    @comment          = @post.comments.new comment_params
    @comment.user     = current_user

    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_post_owner(@comment).deliver_later
        format.html {redirect_to post_path(@post), notice: "comment created"}
        format.js {render :create_success}
      else
        format.html {render "/posts/show"}
        format.js {render :create_failure}
      end
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
    @post = Post.find_by_title params[:post_id]
    @comment = Comment.find params[:id]
    redirect_to root_path, alert: "access defined" unless can? :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to post_path(@post), notice: "comment deleted"}
      format.js {render}
    end
  end

private

  def find_comment
    @comment = Comment.find params[:id]
  end


end
