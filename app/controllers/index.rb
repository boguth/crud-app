get '/' do
  @books = Book.all
  erb :index
end
