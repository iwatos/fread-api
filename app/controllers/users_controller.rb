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
    array =[false]
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = SecureRandom.urlsafe_base64
      @user.remember_digest = token
      @user.save
      array =[true,@user.name,token]
    end
    render json: array
  end

  #新規登録
  def signup
    token = SecureRandom.urlsafe_base64
    @user = User.new(name: params[:name],email: params[:email], password: params[:password],remember_digest: token)
    @user.save
    render json: [true,@user.name,token]
  end

  def get_feed
    response = Array.new(0)
    user = User.find_by(name: params[:name])
    if user
      tabs = Tab.where(user_id: user.id)
      response.push(tabs.pluck("name"))
      urls = Array.new(0)
      tabs.pluck("id").each do | tab |
        urls.push(List.where(tab_id: tab).pluck("url"))
      end
      response.push(urls)
    end

    render json: response
  end

  #認証
  def certification
    result = false
    if User.find_by(name: params[:name]).remember_digest == params[:token]
      result = true
    end
    return result
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
