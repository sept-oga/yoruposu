class Admin::GroupsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @post = Post.new
    @groups = Group.all.order(created_at: :desc)
  end

  def show
    @post = Post.new
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
