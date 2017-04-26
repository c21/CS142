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
end
