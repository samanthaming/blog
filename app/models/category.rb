class Category < ActiveRecord::Base
  validates :title, presence: true, length: {minimum:1, maximum: 255}
end
