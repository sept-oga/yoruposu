class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :now
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
