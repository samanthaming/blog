class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]


  def new
    @user = User.new
  end

  def create

    @user = User.new user_params

    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Thanks for signing up!"
    else
      render :new
    end

  end

  def show

  end

  def edit

  end

  def update
    if @user.update user_params
      redirect_to user_path(@user), notice: "Account Updated"
    else
      flash[:alert] = "Account Failed to update"
      render :edit
    end
  end

  def edit_password
    @user = current_user
    render "users/edit_password"
  end

  def update_password
    @user = current_user

    if (
          @user.authenticate(params[:user][:current_password]) &&
          passwords_match?(params[:user][:password], params[:user][:password_confirmation]) &&
          @user.update(user_params)
      )
      redirect_to edit_password_path, notice: "Password updated"
    else
      flash[:alert] = "Wrong Credentials"
      render "users/edit_password"
    end

  end


  private


  def find_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def passwords_match?(password, confirm_password)
    password == confirm_password ? true : false
  end

end
