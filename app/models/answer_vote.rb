class AnswerVote < ActiveRecord::Base

  belongs_to :voter, :class_name => "User"
  belongs_to :answer

  validates :answer, :voter, :value, { presence: true }
  validates :voter, uniqueness: { scope: :answer }

  def self.evaluate_upvote(current_user, current_answer)
    answer_vote = AnswerVote.find_by(voter: current_user, answer: current_answer)
    if answer_vote && answer_vote.value == -1
        answer_vote.destroy
        upvote(current_user,current_answer)
    elsif answer_vote
        answer_vote.destroy
        {vote_count: current_answer.score, upvoted: false}.to_json
    else
        upvote(current_user,current_answer)
    end
  end

  def self.upvote(current_user, current_answer)
    current_answer.votes << AnswerVote.new(voter: current_user, value: 1)
    {vote_count: current_answer.score, upvoted: true}.to_json
  end

  def self.evaluate_downvote(current_user, current_answer)
    answer_vote = AnswerVote.find_by(voter: current_user, answer: current_answer)
    if answer_vote && answer_vote.value == 1
        answer_vote.destroy
        downvote(current_user,current_answer)
    elsif answer_vote
        answer_vote.destroy
        {vote_count: current_answer.score, downvoted: false}.to_json
    else
        downvote(current_user,current_answer)
    end
  end

  def self.downvote(current_user, current_answer)
    current_answer.votes << AnswerVote.new(voter: current_user, value: -1)
    {vote_count: current_answer.score, downvoted: true}.to_json
  end
end
