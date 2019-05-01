class ListsController < ApplicationController
  require "feedjira"
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

   #feed取得
  def get_feed
    if params[:url]
      rss = Feedjira::Feed.fetch_and_parse(params[:url])
      entries = []
      rss.entries.each do |item|
        entries += [
          :title => item.title,
          :url => item.url
        ]
      end
    end
    feed = {
      :title => rss.title,
      :url => rss.url,
      :entries => entries
    }
    render json: feed
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:name)
    end
end
