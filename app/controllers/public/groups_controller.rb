class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def new
    @group =Group.new
  end

  def index
    @post = Post.new
    @groups = Group.all.order(created_at: :desc)
  end

  def show
    @post = Post.new
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupMember.create(user_id: @group.owner_id, group_id: @group.id)
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render "edit"
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def permits
    @group = Group.find(params[:id])
    @users = @group.users
    @permits = @group.permits.page(params[:page])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: "グループオーナーのみ遷移できます。"
    end
  end

end
