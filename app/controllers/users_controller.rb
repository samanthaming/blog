class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]


  def new
    @user = User.new
  end

  def create

    @user = User.new user_params(:password, :password_confirmation)

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

    password_params = params.require(:user).permit(:current_password, :password, :password_confirmation)

    if @user.authenticate(params[:user][:current_password])
      render json: params
      # sign_in(@user)
      # redirect_to root_path, notice: "Signed in"
    else
      flash[:alert] = "Incorrect Password"
      render "users/edit_password"
    end




  end

  private


  def user_params(*fields)
    array = [ :first_name, :last_name, :email ]
    fields.each { |f| array << f }
    params.require(:user).permit(array)
  end

  def find_user
    @user ||= User.find params[:id]
  end

end
