FactoryGirl.define do
  factory :user do
    first_name "john"
    last_name "doe"
    email "john@doe.com"
    password "secret"
    password_confirmation "secret"
    # password_digest "supersecret"
  end
end
