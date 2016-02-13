# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times do
  Post.create title:  Faker::Hipster.sentence(4),
              body:   Faker::Hipster.paragraph
end

%w(Science Health Beauty Pets Sports Fun).each do |cat|
  Category.create(title: cat)
end
