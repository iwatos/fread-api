class TabsController < ApplicationController
  before_action :set_tab, only: [:show, :update, :destroy]

  # GET /tabs
  def index
    @tabs = Tab.all

    render json: @tabs
  end

  # GET /tabs/1
  def show
    render json: @tab
  end

  # POST /tabs
  def create
    @tab = Tab.new(tab_params)

    if @tab.save
      render json: @tab, status: :created, location: @tab
    else
      render json: @tab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tabs/1
  def update
    if @tab.update(tab_params)
      render json: @tab
    else
      render json: @tab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tabs/1
  def destroy
    @tab.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tab_params
      params.require(:tab).permit(:user_id, :name)
    end
end
