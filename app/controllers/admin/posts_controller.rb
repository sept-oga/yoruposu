class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
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
