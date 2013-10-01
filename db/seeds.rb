# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_admins = ["the band", "Bennett", "deletable admin"]

count = 0
first_admins.each do |name|
  # only first two seeded admins are super admins
  count < 2 ? super_status = true : super_status = false
  Admin.create(name: name, password: "test", password_confirmation: "test",
    description: "The password is 'test'. Change this text and the password!",
    super_admin: super_status)
  count += 1
end

# deletable admin's projects
5.times do |i|
  Project.create(admin_id: 3, title: "Project no. #{i + 1}", description:
    "<a href='http://www.yahoo.com'>Link to this project</a>", order_num: i + 1)
end

past_albums = [["Yearling's Bobtail I", "2013-06-01 00:00:00"],
  ["Yearling's Bobtail II", "2013-06-01 00:00:00"],
  ["Rosalind Franklin Meets<br>Her Pepper's Ghost", "2012-03-01 00:00:00"]]

past_albums.each do |album|
  Album.create(title: album[0], date: album[1],
    description: "Add description!")
end

ybi_songs = ["Didi", "Willy the Cocoa", "Dear Saskia", "Odin", "Ash Wednesday",
  "Pchelka's Starry Journey", "M", "Good Night, Sita", "Grasshoppers Lie Heavy"]
ybii_songs = ["Constellations!", "Look Back in Anger", "Garryowen",
  "On a Golden Cord", "Kyon?", "Uncanny Valley Boy", "Cremated",
  "Vegan Proclamation", "My 100,000th Dream"]
rfmhpg_songs = ["Young Rosalind at the World's Fair", "All the Peppy Paulinas",
  "Coffee in a Crucible", "Ruptures", "Photograph 51", "Unhatched", "Honest Jim",
  "Rosalind's Mosaic Path", "Last Labours", "Whale Fall"]

ybi_songs.each do |song|
  Song.create(title: song, album_id: 1, lyrics: "Add lyrics!")
end
ybii_songs.each do |song|
  Song.create(title: song, album_id: 2, lyrics: "Add lyrics!")
end
rfmhpg_songs.each do |song|
  Song.create(title: song, album_id: 3, lyrics: "Add lyrics!")
end

first_news = [["Welcome to our website!",
  "Hi everyone, we're live! Have a look around!"]]

first_news.each do |news|
  NewsItem.create(heading: news[0], entry: news[1])
end

past_shows = [["Goodbye Blue Monday", "Brooklyn", "NY", "2008-10-27 00:00:00"],
  ["Pete's Candy Store", "Williamsburg", "NY", "2008-10-13 00:00:00"],
  ["Lucky Cat", "Williamsburg", "NY", "2008-10-03 00:00:00"],
  ["Pete's Candy Store", "Williamsburg", "NY", "2008-05-11 00:00:00"],
  ["Sputnik", "Williamsburg", "NY", "2008-04-27 00:00:00"],
  ["R Bar", "New York", "NY", "2008-01-23 00:00:00"],
  ["Luna Lounge", "Williamsburg", "NY", "2007-09-23 00:00:00"],
  ["Pete's Candy Store", "Williamsburg", "NY", "2007-08-29 00:00:00"],
  ["Desmond's", "New York", "NY", "2007-08-10 00:00:00"],
  ["Luna Lounge", "Williamsburg", "NY", "2007-06-03 00:00:00"],
  ["Pete's Candy Store", "Williamsburg", "NY", "2007-05-14 00:00:00"],
  ["The Gig", "Hollywood", "CA", "2006-10-18 00:00:00"],
  ["Sea Level Records", "Echo Park", "CA", "2006-07-15 00:00:00"],
  ["Talking Stick", "Santa Monica", "CA", "2006-07-07 00:00:00"],
  ["Silverlake Lounge", "Los Angeles", "CA", "2006-06-27 00:00:00"],
  ["Knitting Factory", "Hollywood", "CA", "2006-05-14 00:00:00"],
  ["The Gig", "Hollywood", "CA", "2006-05-02 00:00:00"]]

past_shows.each do |show|
  ShowsItem.create(name: show[0], city: show[1], state: show[2], date: show[3])
end















