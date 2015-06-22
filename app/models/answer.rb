class Answer < ActiveRecord::Base

  belongs_to :author, :class_name => "User"
  belongs_to :question
  has_many :votes, :class_name => "AnswerVote"
  has_many :comments, :class_name => "AnswerComment", dependent: :destroy

  validates :author, :content, :question, { presence: true }

  def score
    votes.reduce(0) { |score, vote| score + vote.value }
  end

  def vote_by_current_user(current_user)
    votes.find_by(voter: current_user)
  end

  def upvoted_by_current_user?(current_user)
    if vote = vote_by_current_user(current_user)
      vote.value == 1
    else
      false
    end
  end

  def downvoted_by_current_user?(current_user)
    if vote = vote_by_current_user(current_user)
      vote.value == -1
    else
      false
    end
  end
end
