class PhotosController < ApplicationController
  def index
    @photos = []
    @user = ''
    if params.key?(:id)
      @photos = Photo.where(user_id: params[:id])
      user = User.find_by(id: params[:id])
      if !user.nil?
        @user = "#{user.first_name} #{user.last_name}"
      end
    end 
  end

  def new
  end

  def create
    if params.key?(:photo) && params[:photo].key?(:photo_file)
      photo_file = params[:photo][:photo_file]
      user = User.find_by(id: session[:user_id])
      if !user.nil?
        # Create a record for photo in database.
        Photo.create(user_id: user.id, date_time: DateTime.now,
          file_name: photo_file.original_filename)
        # Save photo to application's directory.
        File.open(Rails.root.join('app', 'assets', 'images',
          photo_file.original_filename), 'wb') do |f|
          f.write(photo_file.read)
        end 
        redirect_to("/photos/index/#{user.id}")
      else
        render(:new, :locals => { :user_error => true })
      end
    else
      render(:new, :locals => { :photo_error => true })
    end
  end

  def post_tag
    tag = Tag.new
    tag.photo_id = params[:tag][:photo_id]
    tag.user_name = params[:tag][:user_name]
    tag.left = params[:tag][:left]
    tag.top = params[:tag][:top] 
    tag.width = params[:tag][:width] 
    tag.height = params[:tag][:height]
    photo = Photo.find_by(id: tag.photo_id)
    if tag.save
      redirect_to("/photos/index/#{photo.user_id}")
    end 
  end

  def search
    # Get searched string.
    string = params[:s].downcase

    @photos = Set.new([])
    # 1. Search for photos with matched comment.
    Comment.where('lower(comment) like ?', "%#{string}%").each do |comment|
      @photos.add(Photo.find_by(id: comment.photo_id))
    end
    # 2. Search for photos with matched tag.
    Tag.where('lower(user_name) like ?', "%#{string}%").each do |tag|
      @photos.add(Photo.find_by(id: tag.photo_id))
    end
  end
end
