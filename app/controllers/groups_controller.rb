class GroupsController < ApplicationController
  before_action :set_group , only: [:edit, :destroy]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_column(params[:name], params[:value])
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  def destroy
    if @group.destroy
      render :json => {status: "success", message: "success"}
    else
      render :json => {status: "failed", message: "failed"}
    end
  end

  private 
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :tournament_id)
  end
end
