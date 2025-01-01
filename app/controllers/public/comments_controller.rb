class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    body = current_user.comments.new(comment_params)
    body.post_id = post.id
    if body.save
      redirect_to post_path(post)
    else
      flash[:alert] = "コメントを入力してください。"
      redirect_to post_path(post)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
