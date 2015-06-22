post '/users' do
  @user = User.new(params[:new_user])
  if @user.save
    redirect '/'
  else
    erb :'/users/new'
  end
end

post '/users/login' do
  authenticated = User.authenticate(params[:email], params[:password])
  if authenticated
    session[:user_id] = authenticated.id
    redirect '/'
  else
    @invalid_login = "Please enter a valid email and password"
    @questions = Question.all.order(created_at: :DESC)
    erb :index
  end

end

get '/users/new' do
  @user = User.new
  erb :"/users/new"
end

delete '/logout' do
  logout_user
  redirect '/'
end


