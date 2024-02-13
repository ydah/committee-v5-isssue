class GroupsController < ApplicationController
  before_action :set_group, only: %i[ update ]

  # GET /groups
  def index
    @groups = Group.all

    render json: @groups, status: :ok
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: @group, status: :ok
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name)
    end
end
