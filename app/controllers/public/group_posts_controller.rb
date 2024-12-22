class Public::GroupPostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find_by(params[:group_id])
    @group_post = GroupPost.new
  end
  
  def create
    @group_post = GroupPost.new(group_post_params)
    @group_post.group_id = params[:group_id]
    @group_post.user_id = current_user.id
    if @group_post.save
      redirect_to group_group_posts_path
    else
      render :new
    end
  end

  def index
    @group_posts = GroupPost.page(params[:page])
  end

  def show
    @group_post = GroupPost.find(params[:id])
    @user = @group_post.user
  end
    
  private
    def group_post_params
      params.require(:group_post).permit(:title, :body)
    end
end
