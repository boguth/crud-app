class QuestionCommentVote < ActiveRecord::Base

  belongs_to :voter, :class_name => "User"
  belongs_to :question_comment

  validates :question_comment, :voter, :value, { presence: true }
  validates :voter, uniqueness: { scope: :question_comment }


  def self.evaluate_upvote(current_user, current_comment)
    question_comment_vote = QuestionCommentVote.find_by(voter: current_user, question_comment: current_comment)
    if question_comment_vote && question_comment_vote.value == -1
        question_comment_vote.destroy
        upvote(current_user,current_comment)
    elsif question_comment_vote
        question_comment_vote.destroy
        {vote_count: current_comment.score, upvoted: false}.to_json
    else
        upvote(current_user,current_comment)
    end
  end

  def self.upvote(current_user, current_comment)
    current_comment.votes << QuestionCommentVote.new(voter: current_user, value: 1)
    {vote_count: current_comment.score, upvoted: true}.to_json
  end

  def self.evaluate_downvote(current_user, current_comment)
    question_comment_vote = QuestionCommentVote.find_by(voter: current_user, question_comment: current_comment)
    if question_comment_vote && question_comment_vote.value == 1
        question_comment_vote.destroy
        downvote(current_user,current_comment)
    elsif question_comment_vote
        question_comment_vote.destroy
        {vote_count: current_comment.score, downvoted: false}.to_json
    else
        downvote(current_user,current_comment)
    end
  end

  def self.downvote(current_user, current_comment)
    current_comment.votes << QuestionCommentVote.new(voter: current_user, value: -1)
    {vote_count: current_comment.score, downvoted: true}.to_json
  end
end
