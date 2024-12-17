class Admin::GroupMembersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def destroy
    group_member = current_user.group_members.find_by(group_id: params[:group_id])
    group_member.destroy
    redirect_to request.referer
  end
end
