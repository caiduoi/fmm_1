class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def edit
    @user = User.find params[:id]
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "This profile have been updated..."
      redirect_to @user
    else
    render action: 'edit'
    end
  end

  def show
    @user = User.find params[:id]
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :password, :password_confirmation, :profile)
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_path unless current_user? @user
  end
end
