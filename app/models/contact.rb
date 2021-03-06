class Contact < ActiveRecord::Base
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, length: {minimum:1, maximum:255}
  validates :subject, length: {minimum:1, maximum:255}
end
