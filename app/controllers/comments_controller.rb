class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to book_path(comment.book), success: t('defaults.message.created', item: Comment.model_name.human)
    else
      redirect_to book_path(comment.book), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(book_id: params[:book_id])
  end
end