class User < ActiveRecord::Base
  has_many :books, foreign_key: :author_id
  has_many :publishers, through: :books
end
