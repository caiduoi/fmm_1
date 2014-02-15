class Admin::TeamsController < ApplicationController
	def index
    @teams = Team.paginate page: params[:page], per_page: 5 
  end

  def show
    @team = Team.find params[:id]
  end

  def destroy
    @team = Team.find params[:id]
    Team.transaction do
        User.transaction(requires_new: false) do
          @team.users.each do |user|
            user.update_attributes leader_flag: 0
            @team.users.delete user
          end
          if @team.destroy
            flash[:success] = "Success destroyed"
          else
            flash[:error] = "Destroy Failed"
          end
        end
      end
    redirect_to admin_teams_path
  end

  def edit
    @team = Team.find params[:id]
    @free_users = []
    if params[:type] == "get_free_member"
      @free_users = User.free_users.paginate page: params[:page], per_page: 5 
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def new
    @free_users = User.free_users
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if !params[:leader_id].nil? and params[:user_ids].respond_to?(:each)
      Team.transaction do
        User.transaction(requires_new: false) do
          params[:user_ids].each do |user_id|
            @user = User.find user_id
            @team.users << @user
          end
          @leader = User.find params[:leader_id]
          @team.users << @leader
          @leader.update_attributes leader_flag: 1
          @team.save
          flash[:success] = "Created team"
        end
      end
      redirect_to admin_teams_path
    else
      flash[:error] = "Failed create team"
      redirect_to new_admin_team_path
    end
  end

  def update
    @team = Team.find params[:id]
    Team.transaction do
      User.transaction(requires_new: false) do
        if params[:user_remove_ids].respond_to?(:each)
          params[:user_remove_ids].each do |user_id|
            @user = User.find user_id
            @team.users.delete @user
          end
        end

        if params[:user_add_ids].respond_to?(:each)
          params[:user_add_ids].each do |user_id|
            @user = User.find user_id
            @team.users << @user
          end
        end

        if !params[:leader_id].nil?
          @team.users.each do |user|
            if user.leader_flag == 1
              user.update_attributes leader_flag: 0
            end
          end
          @leader = User.find params[:leader_id]
          @leader.update_attributes leader_flag: 1
        end
        @team.save
        flash[:success] = "Save success"
      end
    end
    redirect_to admin_teams_path
  end

  def team_params
    params.require(:team).permit(:name, :description )
  end
end
