class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:edit, :update, :destroy, :show]
  before_action :correct_user,    only: [:edit, :update, :destroy]
  before_action :redirect_if_signed_in, only: [:new, :create]
  before_action :admin_user,      only: [:destroy]
  include CarProfilesHelper
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenido!!"
      # redirect_to user_path(@user.id)
      # This is the same thing as:
      redirect_to user_path @user # more likely to see this in professional world
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.car_profiles.count > 0
      render 'show'
    else
      redirect_to new_car_profile_path
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to user_path @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User terminated."
    redirect_to users_path
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      # If my user.id == 1, I try to go to users/2/edit
      @user = User.find(params[:id]) # @user == User.find(2) == Marc's profile
      # Redirect back to /users/1 unless 1 == 2
      redirect_to(user_path(current_user)) unless current_user?(@user)
    end

end