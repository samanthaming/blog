require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do
    it "requires a title" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:title)
    end
    it "requires minimum length of 7 characters" do
      new_post = Post.create({title: "one"})
      new_post.valid?
      expect(new_post.errors).to have_key(:title)
    end
    it "requires a body" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:body)
    end


  end

  describe "class methods" do
    it "has a body_snippet method" do
      expect(Post).to respond_to(:body_snippet).with(1).argument
    end
  end

  # Write tests for your `Post` model in your Blog project.  Add tests for the following:
  # - Test drive a method `body_snippet` method that returns ???
  #     - a maximum of a 100 characters with "..." of the body if it's more than a 100 characters long.

end
