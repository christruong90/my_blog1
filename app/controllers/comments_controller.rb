class CommentsController < ApplicationController

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
    @comment.post = @post 
    if @comment.save
      redirect_to post_path(@post), notice: "comment created"
    else
      render "/questions/show"
    end
  end

  def show
    @comment = Comment.find params[:id]
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Post.find params[:id]
    @comment.destroy
    redirect_to post_path(@post), notice: "comment deleted"
  end

end
