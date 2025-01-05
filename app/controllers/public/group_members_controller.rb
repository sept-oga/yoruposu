class Public::GroupMembersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_member = GroupMember.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy
    redirect_to request.referer
  end
  
  # def destroy
  #   group = Group.find(params[:group_id])
  #   group_member = GroupMember.find(params[:id])
  #   if current_user == group.owner.id || current_user.id == group_member.user_id
  #     group_member.destroy
  #     redirect_to request.referer
  #   else
  #     redirect_to group_path(group), alert: '削除する権限がありません'
  #   end
  # end

  def destroy
    # group_member = current_user.group_members.find_by(group_id: params[:group_id])
    group_member = GroupMember.find_by(group_id: params[:group_id], user_id: params[:user_id])
    group_member.destroy
    redirect_to request.referer
  end
end
