class AnswerCommentVote < ActiveRecord::Base

  belongs_to :voter, :class_name => "User"
  belongs_to :answer_comment

  validates :voter, :answer_comment, :value, { presence: true }
  validates :voter, uniqueness: { scope: :answer_comment }


  def self.evaluate_upvote(current_user, current_comment)
    answer_comment_vote = AnswerCommentVote.find_by(voter: current_user, answer_comment: current_comment)
    if answer_comment_vote && answer_comment_vote.value == -1
        answer_comment_vote.destroy
        upvote(current_user,current_comment)
    elsif answer_comment_vote
        answer_comment_vote.destroy
        {vote_count: current_comment.score, upvoted: false}.to_json
    else
        upvote(current_user,current_comment)
    end
  end

  def self.upvote(current_user, current_comment)
    current_comment.votes << AnswerCommentVote.new(voter: current_user, value: 1)
    {vote_count: current_comment.score, upvoted: true}.to_json
  end

  def self.evaluate_downvote(current_user, current_comment)
    answer_comment_vote = AnswerCommentVote.find_by(voter: current_user, answer_comment: current_comment)
    if answer_comment_vote && answer_comment_vote.value == 1
        answer_comment_vote.destroy
        downvote(current_user,current_comment)
    elsif answer_comment_vote
        answer_comment_vote.destroy
        {vote_count: current_comment.score, downvoted: false}.to_json
    else
        downvote(current_user,current_comment)
    end
  end

  def self.downvote(current_user, current_comment)
    current_comment.votes << AnswerCommentVote.new(voter: current_user, value: -1)
    {vote_count: current_comment.score, downvoted: true}.to_json
  end
end
