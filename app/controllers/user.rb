get '/sessions/new' do
  if request.xhr?
    erb :"/users/login", layout: false
  else
    erb :"/users/login"
  end
end

post '/sessions' do
  if request.xhr?
    if User.authenticate(params[:username], params[:password])
       @user = User.find_by(username: params[:username])
       session[:user_id] = @user.id
       erb :"_header", layout: false
    else
      @error = "Please enter a valid username and password."
      content_type :json
      @error.to_json
    end
  else
    if User.authenticate(params[:username], params[:password])
       @user = User.find_by(username: params[:username])
       session[:user_id] = @user.id
       redirect '/'
    else
      @error = "Please enter a valid username and password."
      erb :"/users/login"
    end
  end
end

delete '/sessions' do
  session[:user_id] = nil
  redirect "/"
end
