class Admin::ProjectsController < ApplicationController
  # before_action :signed_in_user, :new, :create, :index, :show, :edit, :update, :destroy
  # before_action :admin_user, :new, :create, :edit, :update, :destroy
  
  def new
    @project = Project.new
    @users = User.all
    @users.each do |user|
      @project.user_position_in_projects.build user_id: user.id
    end
  end
  
  def create
    @project = Project.new project_params
    if @project.save
      flash.now[:success] = "Created position"
      redirect_to admin_projects_path
    else
      redirect_to root_path
    end
  end
  
  def index
    @projects = Project.paginate page: params[:page], per_page: 3 
  end
  
  def show
    @project = Project.find params[:id]
    @users = @project.users
  end
  
  def edit
    @project = Project.find params[:id]
  end
  
  def update
    @project = Project.find params[:id]
    if !@project.nil?
      if @project.update_attributes project_params
        flash.now[:success] = "Updated Project"
        redirect_to admin_project_path @project
      else
        render :edit
      end
    else
      render root_path
    end
  end  
  
  def destroy
    @project = Project.find params[:id]
    if !@project.nil?
      if @project.destroy 
        flash.now[:success] = "Updated Position"
        redirect_to admin_projects_path
      else
        render :edit
      end
    else
      render root_path
    end
  end
  
  private
  def project_params
    params.require(:project).permit(:name, :abbreviation, 
                                    :startdate, :enddate, :team_id, 
        user_position_in_projects_attributes: [:member, :user_id, 
                                               :position_id])
  end
  
  def admin_user
    redirect_to root_path unless admin_user? current_user
  end
  
end