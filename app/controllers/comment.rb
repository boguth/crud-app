get '/questions/:question_id/comments/new' do
  redirect_if_invalid_user
  @route = "/questions/#{params['question_id']}/comments"
  erb :"comments/new"
end

post'/questions/:question_id/comments' do
  redirect_if_invalid_user
  comment = QuestionComment.new(content: params['content'])
  comment.author = current_user
  comment.question_id = params['question_id']
  if comment.save
    redirect "/questions/#{params['question_id']}"
  else
    erb :"comments/new"
  end
end

get '/questions/:question_id/comments/:comment_id/edit' do
  @question = Question.find_by(id: params[:question_id])
  @comment = QuestionComment.find_by(id: params[:comment_id])
  if request.xhr?
    erb :"/comments/_edit"
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
end

get '/answers/:answer_id/comments/new' do
  redirect_if_invalid_user
  @route = "/answers/#{params['answer_id']}/comments"
  erb :"comments/new"
end

post '/answers/:answer_id/comments' do
  redirect_if_invalid_user
  question_id = Answer.find_by_id(params['answer_id']).question.id
  comment = AnswerComment.new(content: params['content'])
  comment.author = current_user
  comment.answer_id = params['answer_id']
  if comment.save
    redirect "/questions/#{question_id}"
  else
    erb :"comments/new"
  end
end

delete '/questions/:question_id/comments/:comment_id' do
  redirect_if_invalid_user
  current_question = Question.find_by_id(params[:question_id])
  comment = QuestionComment.find_by_id(params[:comment_id])
  if comment.author.id != current_user.id
    redirect "/questions/#{params[:question_id]}"
  end
  comment.destroy
  redirect "/questions/#{params[:question_id]}"
end

delete "/answers/:answer_id/comments/:comment_id" do
  redirect_if_invalid_user
  answer = Answer.find_by_id(params[:answer_id])
  current_question = answer.question
  comment = AnswerComment.find_by_id(params[:comment_id])
  if comment.author.id != current_user.id
    redirect "/questions/#{current_question.id}"
  end
  comment.destroy
  redirect "/questions/#{current_question.id}"
end

get '/answers/:answer_id/comments/:comment_id/edit' do
  question_id = Answer.find_by(id: params[:answer_id]).question.id
  @question = Question.find_by(id: question_id)
  @answer = Answer.find_by(id: params[:answer_id])
  @answer_comment = AnswerComment.find_by(id: params[:comment_id])
  erb :'/answer_comments/edit'
end

put '/answers/:answer_id/comments/:comment_id/edit' do
  question_id = Answer.find_by(id: params[:answer_id]).question.id
  question = Question.find_by(id: question_id)
  answer_comment = AnswerComment.find_by(id: params[:comment_id])
  if owner?(current_user_id)
    answer_comment.update_attributes(content: params[:comment])
    redirect "/questions/#{question.id}"
  else
    @unauthorized = "You must be logged in to edit the post"
    redirect "/questions/#{question.id}"
  end
end
