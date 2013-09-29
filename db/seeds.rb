# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_admins = ["the band", "Bennett"]

first_admins.each do |name|
  Admin.create(name: name, password: "test", password_confirmation: "test",
    description: "Change this text. The password is 'test'.", super_admin: true)
end

first_albums = [["Yearling's Bobtail I", "2013-06-01 00:00:00"],
  ["Yearling's Bobtail II", "2013-06-01 00:00:00"],
  ["Rosalind Franklin Meets Her Pepper's Ghost", "2012-03-01 00:00:00"]]

first_albums.each do |album|
  Album.create(title: album[0], date: album[1])
end

first_news = [["Welcome to our website!",
  "Hi everyone, we're live! Have a look around!"]]

first_news.each do |news|
  NewsItem.create(heading: news[0], entry: news[1])
end
