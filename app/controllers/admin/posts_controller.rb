class Admin::PostsController < ApplicationController
  layout 'admin'
  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    user = post.user
    post.destroy
    redirect_to admin_user_path(user)
  end
end
