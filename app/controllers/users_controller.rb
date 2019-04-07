class UsersController < ApplicationController
  include ActionController::Cookies
    before_action :set_list, only: [:show, :update, :destroy]
      
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  #ログイン
  def login
    array =["LoginFailed",-1]
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = SecureRandom.urlsafe_base64
      @user.remember_digest = token
      @user.save
      array =["LoginSuccess",@user.id,token]
    end
    render json: array
  end

  #
  def get_feed
    response ="Failed"
    user = User.find_by(id: "3")
    if user
      tabs = Tab.where(user_id: user.id)
      response = Array.new(0)
      tab_array = Array.new(0)
      urls_array = Array.new(0)
      tabs.each do | tab |
        tab_array.push(tab.name)
        url_array = Array.new(0)
        
        urls = List.where(tab_id: tab.id)
        urls.each do | url |
          url_array.push(url.url)
        end
        urls_array.push(url_array)
      end
      response.push(tab_array)
      response.push(urls_array)
    end
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white user" through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
