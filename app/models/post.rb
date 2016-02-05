class Post < ActiveRecord::Base
  validates :title, presence: true,
                    uniqueness: {case_sensitive: false,
                                message: "Already Exists"}
end
