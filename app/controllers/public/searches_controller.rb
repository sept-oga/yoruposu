class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		# model => user か post
		@model = params[:model]
		# content => 検索キーワード
		@content = params[:content]
		# method => 前方一致など
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'post'
			@records = Post.search_for(@content, @method)
		else
			@records = Group.search_for(@content, @method)
		end
	end
end
