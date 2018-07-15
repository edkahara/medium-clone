class PagesController < ApplicationController
	before_action :authenticate_user!, only: [:follow, :unfollow]

	def profile
		if (User.find_by_username(params[:id]))
			@username = params[:id]
			@user = User.find_by_username(@username)
		else
			redirect_to missing_path, :notice => "User not found"
		end

		@stories = @user.stories.newest_first
		@comments = @user.comments.newest_first
		@likes = @user.likes.newest_first
		@bookmarks = @user.bookmarks.newest_first
	end

	def tag
		if (ActsAsTaggableOn::Tag.find_by_name(params[:id]))
			@tag_name = params[:id]
			@tag = ActsAsTaggableOn::Tag.find_by_name(@tag_name)
		else
			redirect_to missing_path, :notice => "Tag not found"
		end

		@stories = Story.with_tag(@tag_name).newest_first
	end

	def follow
		@username = params[:id]
		@user = User.find_by_username(@username)
		Relationship.create(follower_id: current_user.id, following_id: @user.id)
		redirect_to :back
	end

	def unfollow
		@username = params[:id]
		@user = User.find_by_username(@username)
		Relationship.find_by(follower_id: current_user.id, following_id: @user.id).destroy
		redirect_to :back
	end

	def missing
	end

	def about
	end

	def support
	end

	def privacy
	end

	def terms
	end

end
