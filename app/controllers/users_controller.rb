class UsersController < ApplicationController
    def index
        users = User.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'loaded userss', data: users }
    end
end
