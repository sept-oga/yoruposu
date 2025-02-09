class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		# model => user or post or group
		@model = params[:model]
		# content => 検索キーワード
		@content = params[:content]
		# method => 前方一致など
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
