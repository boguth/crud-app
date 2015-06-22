get '/questions/:question_id/answers/new' do
  redirect_if_invalid_user
  @question = Question.find_by_id(params['question_id'])
  erb :"answers/new"
end

post '/questions/:question_id/answers' do
  redirect_if_invalid_user
  current_question = Question.find_by_id(params['question_id'])
  author = current_user
  content = params[:answer]
  new_answer = current_question.answers.new(author: author, content: content)
  if new_answer.save
    redirect "/questions/#{params['question_id']}"
  else
    @failure_message = "Please fill out an answer."
    erb :"answers/new"
  end
end

delete '/questions/:question_id/answers/:answer_id' do
  redirect_if_invalid_user
  current_question = Question.find(params[:question_id])
  current_answer = Answer.find(params[:answer_id])
   if current_answer.author.id != current_user.id
    redirect "/questions/#{params[:question_id]}"
   end
  current_answer.destroy
  redirect "/questions/#{params[:question_id]}"
end

post '/questions/:question_id/answers/:answer_id/best-answer' do
  question = Question.find_by_id(params['question_id'])
  question.best_answer = Answer.find_by_id(params['answer_id'])
  question.save
  redirect "questions/#{params['question_id']}"
end
