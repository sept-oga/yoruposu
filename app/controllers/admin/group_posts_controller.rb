class Admin::GroupPostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @group = Group.find(params[:group_id])
    @group_posts = GroupPost.page(params[:page])
  end

  def show
    @group_post = GroupPost.find(params[:id])
    @user = @group_post.user
  end

  def destroy
    group_post = GroupPost.find(params[:id])
    user = group_post.user
    group_post.destroy
    redirect_to group_group_posts_path
  end

  private

  def group_post_params
    params.require(:group_post).permit(:title, :body)
  end
end
