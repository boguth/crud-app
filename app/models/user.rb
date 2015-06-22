class User < ActiveRecord::Base

  validates :first_name, :last_name, :username, :email, :password_hash, { presence: true }
  validates :email, uniqueness: true, email: true

  has_many :questions, :foreign_key => :author_id
  has_many :answers, :foreign_key => :author_id
  has_many :question_comments, :foreign_key => :author_id
  has_many :answer_comments, :foreign_key => :author_id
  has_many :question_votes, :foreign_key => :voter_id
  has_many :answer_votes, :foreign_key => :voter_id
  has_many :question_comment_votes, :foreign_key => :voter_id
  has_many :answer_comment_votes, :foreign_key => :voter_id

  def self.authenticate(email, password)
    user = User.find_by(:email => email)
    if user && user.password == password
      return user
    else
      return nil
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end
end

