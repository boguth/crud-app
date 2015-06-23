get '/sessions/new' do
  if request.xhr?
    erb :"/users/login", layout: false
  else
    erb :"/users/login"
  end
end

post '/sessions' do
  if User.authenticate(params[:username], params[:password])
     @user = User.find_by(username: params[:username])
     session[:user_id] = @user.id
     redirect '/'
  else
    @error = "Please enter a valid username and password."
    erb :"/users/login"
  end
end

delete '/sessions' do
  session[:user_id] = nil
  redirect "/"
end
