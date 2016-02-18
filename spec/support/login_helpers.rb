module LoginHelpers

  def signed_in(user)
    request.session[:user_id] = user.id
  end

  def not_authenticated
    session[:user_id] = nil
  end
end
