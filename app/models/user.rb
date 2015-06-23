class User < ActiveRecord::Base

  validates :username, :password_hash, presence: true
  validates :username, uniqueness: true

  has_many :books, foreign_key: :author_id
  has_many :publishers, through: :books

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

   def self.authenticate(username, password)
    user = User.find_by(:username => username)
    if user && user.password == password
      return user
    else
      return nil
    end
   end

end
