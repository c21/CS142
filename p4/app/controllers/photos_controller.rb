class PhotosController < ApplicationController
  def index
    @photos = []
    @user = ''
    if params.key?(:id)
      @photos = Photo.where(user_id: params[:id])
      if !@photos.empty?
        first_name = @photos[0].user.first_name
        last_name = @photos[0].user.last_name
        @user = "#{first_name} #{last_name}"
      end
    end 
  end
end
