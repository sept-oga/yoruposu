class Public::GroupMembersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_member = GroupMember.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy
    redirect_to request.referer
  end

  def destroy
    group_member = GroupMember.find_by(group_id: params[:group_id], user_id: params[:user_id])
    group_member.destroy
    redirect_to request.referer
  end
end
