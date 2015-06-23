class Book < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :publisher

end
