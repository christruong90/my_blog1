class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit_password]

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params

      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Your account has been created"
      else
        render:new
      end
    end

    def edit
      @user = User.find params[:id]
    end

    def update
      @user = User.find params[:id]
      @user.update(user_params)
      redirect_to root_path, notice: "Your account has been updated"
    end

    def edit_password
      @user = User.find params[:id]
    end

    def update_password
      # byebug
      @user = User.find params[:id]
      if @user.authenticate(user_params[:old_password])
      new_password_params = params.require(:user).permit(:password, :password_confirmation)
        @user.update(new_password_params)
        redirect_to root_path, notice: "Your password has been updated"
      else
        flash[:alert] = "Wrong credentials!"
        render :edit_password
      end

    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :old_password)
    end

    def authenticate_user!
      redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
    end

end
