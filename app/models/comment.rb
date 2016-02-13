class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, presence: true, uniqueness: {scope: :post_id}





end
