class Admin::GroupPostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html do
        @group_posts = @group.group_posts.page(params[:page]).order(created_at: :desc)
      end
      format.json do
        @group_posts = @group.group_posts
      end
    end
  end

  def show
    @group_post = GroupPost.find(params[:id])
    @user = @group_post.group_member.user
  end

  def destroy
    group_post = GroupPost.find(params[:id])
    user = group_post.group_member.user
    group_post.destroy
    redirect_to admin_group_group_posts_path
  end

  private

  def group_post_params
    params.require(:group_post).permit(:title, :body, :gp_image, :address)
  end
end
