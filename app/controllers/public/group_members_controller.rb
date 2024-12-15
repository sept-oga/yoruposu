class Public::GroupMembersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    group_member = current_user.group_members.new(group_id: params[:group_id])
    group_member.save
    redirect_to request.referer
  end
  
  def destroy
    group_member = current_user.group_members.find_by(group_id: params[:group_id])
    group_member.destroy
    redirect_to request.referer
  end
end
