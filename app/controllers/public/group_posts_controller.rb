class Public::GroupPostsController < ApplicationController
  before_action :is_user_included
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.new
  end
  
  def create
    @group_post = GroupPost.new(group_post_params)
    @group_post.group_id = params[:group_id]
    @group_post.user_id = current_user.id
    if @group_post.save
      redirect_to group_group_post_path(@group_post.group_id, @group_post)
    else
      render :new
    end
  end

  def index
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html do
        @group_posts = @group.group_posts.page(params[:page])
      end
      format.json do
        @group_posts = @group.group_posts
      end
    end
  end

  def show
    @group_post = GroupPost.find(params[:id])
    @user = @group_post.user
  end

  def edit
    @group_post = GroupPost.find(params[:id])
  end

  def update
    @group_post = GroupPost.find(params[:id])
    if @group_post.update(group_post_params)
      redirect_to group_group_post_path(@group_post.group_id, @group_post)
    else
      render :edit
    end
  end

  def destroy
    group_post = GroupPost.find(params[:id])
    user = group_post.user
    group_post.destroy
    redirect_to group_group_posts_path
  end

  private

  def group_post_params
    params.require(:group_post).permit(:title, :body, :gp_image, :address)
  end

  def is_user_included
    group = Group.find(params[:group_id])
    unless group.includesUser?(current_user) || group.is_owned_by?(current_user)
      redirect_to group_path(group)
      flash[:alert] = "このグループにアクセスする権限がありません。"
    end
  end

  def is_matching_login_user
    group_post = GroupPost.find(params[:id])
    user = group_post.user
    unless user.id == current_user.id
      redirect_to group_group_post_path(group_post.group_id, group_post)
      flash[:alert] = "投稿者のみが編集できます。"
    end
  end

end
