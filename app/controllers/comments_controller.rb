class CommentsController <ApplicationController
  before_action :require_user

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #flash[:success] = "Comment was created successfully"
      #redirect_to article_path(@article)
    else
      flash[:danger] = "Comment was not created"
      redirect_to article_path(@article)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end