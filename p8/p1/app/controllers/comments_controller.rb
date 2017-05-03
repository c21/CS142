class CommentsController < ApplicationController
  def new
    @comment = Comment.new(photo_id: params[:id], user_id: session[:user_id])
  end

  def create
    @comment = Comment.new
    @comment.photo_id = params[:id]
    @comment.user_id = session[:user_id]
    @comment.date_time = DateTime.now
    @comment.comment = params[:comment][:comment]
    if @comment.save
      photo = Photo.find_by(id: @comment.photo_id)
      redirect_to("/photos/index/#{photo.user_id}")
    else
      render(:new)
    end
  end
end
