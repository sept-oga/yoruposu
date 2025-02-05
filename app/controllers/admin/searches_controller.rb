class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
	layout 'admin'

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'post'
			@records = Post.search_for(@content, @method).order(created_at: :desc)
		else
			@records = Group.search_for(@content, @method)
		end
	end
end
