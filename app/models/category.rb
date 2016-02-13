class Category < ActiveRecord::Base
  has_many :posts, dependent: :nullify
  validates :title, presence: true, length: {minimum:1, maximum: 255}



end
