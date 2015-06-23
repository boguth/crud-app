helpers do
  def login_authorization
    if session[:user_id] == nil
      redirect '/'
    end
  end

  def user
    User.find_by_id(session[:user_id])
  end

  def user_id
    user = User.find_by_id(session[:user_id])
    user.id
  end

end
