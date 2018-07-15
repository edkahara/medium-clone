class StoriesController < ApplicationController
  before_action :set_story, except: [:index, :new, :create, :upload_image]
  before_action :authenticate_user!, except: [:show]

  def index
    @stories = (Story.following_stories current_user.following).newest_first
  end

  def show
  end

  def new
    @story = current_user.stories.new
  end

  def edit
  end

  def create
    @story = current_user.stories.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: "Your story was successfully published!" }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, notice: "Your story wasn't published!" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: "Your story was successfully updated!" }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, notice: "Your story wasn't updated!" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    Like.create(user_id: current_user.id, likeable_id: @story.id, likeable_type: "Story")
    redirect_to @story
  end

  def unlike
    Like.find_by(user_id: current_user.id, likeable_id: @story.id, likeable_type: "Story").destroy
    redirect_to @story
  end

  def bookmark
    Bookmark.create(user_id: current_user.id, bookmarkable_id: @story.id, bookmarkable_type: "Story")
    redirect_to @story
  end

  def unbookmark
    Bookmark.find_by(user_id: current_user.id, bookmarkable_id: @story.id, bookmarkable_type: "Story").destroy
    redirect_to @story
  end

  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: "Your story was successfully deleted!" }
      format.json { head :no_content }
    end
  end

  def upload_image
    image = Story.create params.permit(:file, :alt, :hint )
    render json: {
      image: {
        url: image.file.url
      }
    }, content_type: "text/html"
  end

  private
    def set_story
      @story = Story.friendly.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:title, :banner_image, :file, :alt, :hint, :body, :tag_list)
    end
end
