class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: {case_sensitive: false,
                                message: "Already Exists"},
                    length: {minimum:7}

  validates :body, presence: true

  paginates_per 5


  # Write tests for your `Post` model in your Blog project.  Add tests for the following:
  # - Test drive a method `body_snippet` method that returns ???
  #     - a maximum of a 100 characters with "..." of the body if it's more than a 100 characters long.
  def self.body_snippet(para)
    para[0..97] << "..."
  end

  def category_title
    category.title if category
  end



end
