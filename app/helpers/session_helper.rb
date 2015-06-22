helpers do

  def current_user_id
    @user_id ||= session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logout_user
    session[:user_id] = nil
  end

  def owner?(user_id)
    user_id == current_user_id
  end

  def redirect_if_invalid_user
    redirect '/' if current_user.nil?
  end

  def user?
   session[:user_id] ? true : false
  end

end
#
