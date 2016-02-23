class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  def is_author_of? (model, user=current_user)
    if model.has_attribute? :user_id
      model.user_id == current_user.id ? true : false
    else
      false
    end
  end
  helper_method :is_author_of?
end
