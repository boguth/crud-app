get '/' do
  if user?
    @name = "#{current_user.first_name} #{current_user.last_name}"
  else
    @name = "guest"
  end
  @questions = Question.all.order(created_at: :DESC)
  erb :index
end
