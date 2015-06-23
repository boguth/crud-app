get '/users/login' do

  erb :"/users/login"
end

post '/users/login' do
  if User.authenticate(params[:username], params[:password])
     @user = User.find_by(username: params[:username])
     redirect '/'
  else
    @error = "Please enter a valid username and password."
    erb :"/users/login"
  end
end
