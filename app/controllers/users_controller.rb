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

  def loginUser
    array =["LoginFailed",-1]
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      tabs = Tab.where(user_id: user.id) #tab一覧
      list = Array.new(0)
      tabs.each do | tab |
        list.push(url.url)
      end

      tabs.each do | tab |
        urls = List.where(tab_id: tab.id)
        urls.each do | url |
          list.push(url.url)
        end
      end
      array = list
    end
    render json: array
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
