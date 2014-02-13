class Admin::PositionsController < ApplicationController
  
  def new
    @position = Position.new
  end
  
  def create
    @position = Position.create position_params
    if @position.save
      flash.now[:success] = "Created position"
      redirect_to admin_positions_path
    else
      redirect_to root_path
    end
  end
  
  def index
    @positions = Position.paginate page: params[:page], per_page: 3 
  end
  
  def show
    @position = Position.find params[:id]
  end
  
  def edit
    @position = Position.find params[:id]
  end
  
  def update
    @position = Position.find params[:id]
    if !@position.nil?
      if @position.update_attributes position_params
        flash.now[:success] = "Updated Position"
        redirect_to admin_position_path(@position)
      else
        render root_path
      end
    else
      render root_path
    end
  end
    
  def destroy
    @position = Position.find params[:id]
    if !@position.nil?
      if @position.destroy
        flash.now[:success] = "Updated Position"
        redirect_to admin_positions_path
      else
        render :edit
      end
    else
      render root_path
    end
  end
  
  private
  def position_params
    params.require(:position).permit(:name, :abbreviation)
                                    
  end
  
end