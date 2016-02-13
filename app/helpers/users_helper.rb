module UsersHelper

  def user_first_name
    current_user.first_name.titleize
  end

  def user_full_name
    "#{user_first_name} #{current_user.last_name}".titleize
  end

end
