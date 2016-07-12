class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
      @posts = Post.all
      @favourites = current_user.favourites
  end

  def create
    @post = Post.find params[:post_id]
    f = Favourite.create(post: @post, user: current_user)
    redirect_to post_path(@post), notice: "you have favourited this post"
  end

  def destroy
    favourite = Favourite.find params[:id]
    post = Post.find params[:post_id]
    favourite.destroy if can? :destroy, Favourite
    redirect_to post_path(post), notice: "you have unfavourited this post"
  end

end
