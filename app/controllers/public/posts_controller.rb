class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = post.user
    post.destroy
    redirect_to user_path(user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
end
