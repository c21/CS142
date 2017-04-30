class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login
    # Clean previous cookie.
    session.delete(:user_id)
  end

  def post_login
    user = User.find_by(login: params[:user][:login])
    if !user.nil? && user.password_valid?(params[:user][:password])
      session[:user_id] = user.id
      redirect_to("/photos/index/#{user.id}")
    else
      render(:login, :locals => { :user_error => true })
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to(:action => :login)
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.login = params[:user][:login]
    @user.password = params[:user][:password]  
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to(:action => :login)
    else
      render(:new)
    end
  end 
end
