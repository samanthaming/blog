class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 6}, presence:true, on: :create
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


end
