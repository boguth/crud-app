get '/books/:id/edit' do
  @book = Book.find_by_id(params[:id])
  login_authorization
  if session[:user_id] != @book.author.id
    redirect '/'
  end
  if request.xhr?
    erb :"/books/edit", layout: false
  else
    erb :"/books/edit"
  end
end

put '/books/:id' do
  @book = Book.find_by_id(params[:id])
  login_authorization
  if session[:user_id] != @book.author.id
    redirect '/'
  end
  if request.xhr?
    if @book.update_attributes(title: params[:title])
      erb :"/books/_books", layout: false, :locals => { :book => @book }
    else
      content_type :json
      "Please enter a valid title.".to_json
    end
  else
    if @book.update_attributes(title: params[:title])
      redirect '/'
    else
      erb :"/books/edit"
    end
  end
end
