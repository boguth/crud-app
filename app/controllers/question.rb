get '/questions/new' do
  redirect_if_invalid_user
  erb :"questions/new"
end

post '/questions' do
  redirect_if_invalid_user
  question = Question.new(:title => params['title'], :content => params['content'])
  question.author_id = session['user_id']
  if question.save
    redirect '/'
  else
    erb :"questions/new"
  end
end

get '/questions/:question_id' do
  @question = Question.find_by_id(params[:question_id])
  @best_answer = @question.best_answer
  @answers = @question.answers
  @answers-=[@best_answer] unless @best_answer.nil?
  erb :'/questions/show'
end

get '/questions/:question_id/edit' do
  @question = Question.find_by_id(params[:question_id])
  @answers = @question.answers
  if !owner?(@question.author_id)
    redirect "/questions/#{@question.id}"
  else
    if request.xhr?
      erb :'/questions/_edit'
    else
      erb :'/questions/edit'
    end
  end
end

put '/questions/:question_id/edit' do
  question = Question.find_by_id(params[:question_id])
  if owner?(question.author_id)
    question.update_attributes(params[:question])
  end
  redirect "/questions/#{question.id}"
end

get '/questions/:question_id/comments/:comment_id/edit' do
  @question = Question.find_by(id: params[:question_id])
  @comment = QuestionComment.find_by(id: params[:comment_id])
  if !owner?(@comment.author_id)
    redirect "/questions/#{@question.id}"
  else
    erb :'/comments/edit'
  end
end

put '/questions/:question_id/comments/:comment_id/edit' do
  comment = QuestionComment.find_by(id: params[:comment_id])
  question = Question.find_by(id: params[:question_id])
  if owner?(current_user_id)
    comment.update_attributes(content: params[:content])
    redirect "/questions/#{question.id}"
  else
    @unauthorized = "You must be logged in to edit the post"
    redirect "/questions/#{question.id}"
  end
  redirect "/questions/#{question.id}"
end

get '/questions/:question_id/answers/:answer_id/edit' do
  @question = Question.find_by(id: params[:question_id])
  @answer = Answer.find_by(id: params[:answer_id])
  if !owner?(@answer.author_id)
    redirect "/questions/#{@question.id}"
  else
    erb :'/answers/edit'
  end
end

put '/questions/:question_id/answers/:answer_id/edit' do
  answer = Answer.find_by(id: params[:answer_id])
  question = Question.find_by(id: params[:question_id])
  if owner?(current_user_id)
    answer.update_attributes(content: params[:answer])
  end
  redirect "/questions/#{question.id}"
end

delete '/questions/:question_id' do |question_id|
  question = Question.find_by_id(question_id)
 if current_user_id == nil || question.author != current_user
   redirect '/'
 else
   question.destroy
   redirect '/'
 end
end
