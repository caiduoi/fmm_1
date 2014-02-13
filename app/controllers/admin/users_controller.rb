class Admin::UsersController < ApplicationController

  def index
    @users = User.paginate page: params[:page] , per_page: 5
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "User has been created"
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created"
      render action: 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def destroy
    user = User.find params[:id]
    if !user.nil?
      if user.destroy
        flash[:success] = "Success destroyed"
      else
        flash[:notice] = "Destroy Failed"
      end
      redirect_to admin_users_path
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "This profile have been updated..."
      redirect_to admin_users_path
    else
      render action: 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :permission,
                                                :password, :password_confirmation, :profile)
  end

end
