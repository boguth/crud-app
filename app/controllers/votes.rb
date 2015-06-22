get '/questions/:id/upvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_question = Question.find_by_id(params[:id])

  if !request.xhr?
    current_question.votes << QuestionVote.new(voter: current_user, value: 1)
    @questions = Question.all.order(created_at: :DESC)
    erb :index
  else
    QuestionVote.evaluate_upvote(current_user, current_question)
  end
end


get '/questions/:id/downvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_question = Question.find_by_id(params[:id])

  if !request.xhr?
    current_question.votes << QuestionVote.new(voter: current_user, value: -1)
    @questions = Question.all.order(created_at: :DESC)
    erb :index
  else
    QuestionVote.evaluate_downvote(current_user, current_question)
  end
end

get '/questioncomments/:id/upvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_question_comment = QuestionComment.find_by_id(params[:id])

  if !request.xhr?
    current_question_comment.votes << QuestionCommentVote.new(voter: current_user, value: 1)
    @questions = QuestionComment.all.order(created_at: :DESC)
    erb :index
  else
    QuestionCommentVote.evaluate_upvote(current_user, current_question_comment)
  end
end

get '/questioncomments/:id/downvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_question_comment = QuestionComment.find_by_id(params[:id])

  if !request.xhr?
    current_question_comment.votes << QuestionCommentVote.new(voter: current_user, value: -1)
    @questions = QuestionComment.all.order(created_at: :DESC)
    erb :index
  else
    QuestionCommentVote.evaluate_downvote(current_user, current_question_comment)
  end
end

get '/answercomments/:id/upvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_answer_comment = AnswerComment.find_by_id(params[:id])

  if !request.xhr?
    current_answer_comment.votes << AnswerCommentVote.new(voter: current_user, value: 1)
    @questions = AnswerComment.all.order(created_at: :DESC)
    erb :index
  else
    AnswerCommentVote.evaluate_upvote(current_user, current_answer_comment)
  end
end

get '/answercomments/:id/downvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_answer_comment = AnswerComment.find_by_id(params[:id])

  if !request.xhr?
    current_answer_comment.votes << AnswerCommentVote.new(voter: current_user, value: -1)
    @questions = AnswerComment.all.order(created_at: :DESC)
    erb :index
  else
    AnswerCommentVote.evaluate_downvote(current_user, current_answer_comment)
  end
end

get '/answers/:id/upvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_answer = Answer.find_by_id(params[:id])

  if !request.xhr?
    current_answer.votes << AnswerVote.new(voter: current_user, value: 1)
    @questions = Answer.all.order(created_at: :DESC)
    erb :index
  else
    AnswerVote.evaluate_upvote(current_user, current_answer)
  end
end

get '/answers/:id/downvote' do
  if current_user == nil
    return "Error".to_json
  end
  current_answer = Answer.find_by_id(params[:id])

  if !request.xhr?
    current_answer.votes << AnswerVote.new(voter: current_user, value: -1)
    @questions = Answer.all.order(created_at: :DESC)
    erb :index
  else
    AnswerVote.evaluate_downvote(current_user, current_answer)
  end
end
