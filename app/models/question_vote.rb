class QuestionVote < ActiveRecord::Base

  belongs_to :voter, :class_name => "User"
  belongs_to :question

  validates :question, :voter, :value, { presence: true }
  validates :voter, uniqueness: { scope: :question }

  def self.evaluate_downvote(current_user, current_question)
    question_vote = QuestionVote.find_by(voter: current_user, question: current_question)
    if question_vote && question_vote.value == 1
        question_vote.destroy
        downvote(current_user,current_question)
    elsif question_vote
        question_vote.destroy
        {vote_count: current_question.score, downvoted: false}.to_json
    else
        downvote(current_user,current_question)
    end
  end

  def self.downvote(current_user, current_question)
    current_question.votes << QuestionVote.new(voter: current_user, value: -1)
    {vote_count: current_question.score, downvoted: true}.to_json
  end

    def self.evaluate_upvote(current_user, current_question)
    question_vote = QuestionVote.find_by(voter: current_user, question: current_question)
    if question_vote && question_vote.value == -1
        question_vote.destroy
        upvote(current_user,current_question)
    elsif question_vote
        question_vote.destroy
        {vote_count: current_question.score, upvoted: false}.to_json
    else
        upvote(current_user,current_question)
    end
  end

  def self.upvote(current_user, current_question)
    current_question.votes << QuestionVote.new(voter: current_user, value: 1)
    {vote_count: current_question.score, upvoted: true}.to_json
  end


end
