class CommentsController < ApplicationController
  before_action :set_comment, except: [:create, :upload_image]
  before_action :set_commentable, only: [:create]
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def edit
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back, notice: "Your comment was successfully published!"
    else
      redirect_to :back, notice: "Your comment wasn't published!"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Your comment was successfully updated!"
    else
      redirect_to @comment, notice: "Your comment wasn't updated!"
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path, notice: "Your comment was successfully deleted!"
  end

  def like
    Like.create(user_id: current_user.id, likeable_id: @comment.id, likeable_type: "Comment")
    redirect_to :back
  end

  def unlike
    Like.find_by(user_id: current_user.id, likeable_id: @comment.id, likeable_type: "Comment").destroy
    redirect_to :back
  end

  def bookmark
    Bookmark.create(user_id: current_user.id, bookmarkable_id: @comment.id, bookmarkable_type: "Comment")
    redirect_to :back
  end

  def unbookmark
    Bookmark.find_by(user_id: current_user.id, bookmarkable_id: @comment.id, bookmarkable_type: "Comment").destroy
    redirect_to :back
  end

  def upload_image
    image = Comment.create params.permit(:file, :alt, :hint )
    render json: {
      image: {
        url: image.file.url
      }
    }, content_type: "text/html"
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
    @commentable = Story.friendly.find(params[:story_id]) if params[:story_id]
  end

  def comment_params
    params.require(:comment).permit(:body, :alt, :hint, :file)
  end
end
