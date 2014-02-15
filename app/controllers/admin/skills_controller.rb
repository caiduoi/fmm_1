class Admin::SkillsController < ApplicationController
	def index
    @skills = Skill.all
    @skill = Skill.new
  end

  def destroy
    skill = Skill.find params[:id]

    if skill.destroy
      flash[:notice] = "Success destroyed"
      @skills = Skill.all
    else
      flash[:notice] = "Destroy Failed"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash.now[:success] = "Created skill"
      @skills = Skill.all
    else
      flash.now[:error] = "Failed create"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @skill = Skill.find params[:id]
    if !@skill.nil?
      if @skill.update_attributes skill_params
        flash.now[:success] = "Updated skill"
        redirect_to admin_skills_path
      else
        render :edit
      end
    else
      render root_path
    end
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
