# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
["Life", "electronics", "clothes", "tools", "automotive", "games", "finance", "NSFW", "Relationships", "Pets"].each do |cat|
  Category.create title: cat
end

["Life", "electronics", "clothes", "tools", "automotive", "games", "finance", "NSFW", "Relationships", "Pets"].each do |tag|
  Tag.create name: tag
end
