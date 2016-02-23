module UsersHelper

  def current_user_first_name
    current_user.first_name.titleize
  end

end
