namespace :dev do
  desc "Create random priming data"
  task prime: :environment do
    User.destroy_all
    Photo.destroy_all
    Comment.destroy_all
    Like.destroy_all
    FriendRequest.destroy_all

    usernames = ["alice", "bob", "carol", "dave", "ellen"]

    usernames.each do |username|
      user = User.create
      user.username = username
      user.email = "#{username}@example.com"
      user.password = "12341234"
      user.save
    end

    puts "There are now #{User.count} users in the database."

    photo_info = [
      {
        :image => "astronaut.jpg",
        :caption => "Astronaut"
      },
      {
        :image => "aurora.jpg",
        :caption => "Aurora"
      },
      {
        :image => "birds.jpg",
        :caption => "Birds"
      },
      {
        :image => "bridge.jpg",
        :caption => "Bridge"
      },
      {
        :image => "firebreather.jpg",
        :caption => "Firebreather"
      },
      {
        :image => "horses.jpg",
        :caption => "Horses"
      },
      {
        :image => "lake.jpg",
        :caption => "Lake"
      },
      {
        :image => "lightbulb.jpg",
        :caption => "Lightbulb"
      },
      {
        :image => "penguins.jpg",
        :caption => "Penguins"
      },
      {
        :image => "pluto.jpg",
        :caption => "Pluto"
      },
      {
        :image => "squirrel.jpg",
        :caption => "Squirel"
      },
      {
        :image => "stained_glass.jpg",
        :caption => "Stained glass"
      },
      {
        :image => "sun.jpg",
        :caption => "Sun"
      },
      {
        :image => "telescope.jpg",
        :caption => "Telescope"
      },
      {
        :image => "tower.jpg",
        :caption => "Tower"
      },
      {
        :image => "turtles.jpg",
        :caption => "Turtles"
      }
    ]

    users = User.all

    photo_info.each do |photo_hash|
      filename = photo_hash[:image]

      photo = Photo.new
      photo.image = File.open(Rails.root.join('lib', 'assets', filename).to_s)
      photo.caption = photo_hash[:caption]
      photo.user = users.sample
      photo.created_at = rand(2.years.ago..Time.now)
      photo.save
    end

    puts "There are now #{Photo.count} photos in the database."

    photos = Photo.all

    photos.each do |photo|
      rand(6).times do
        comment = photo.comments.build
        comment.user = users.sample
        comment.body = Faker::Hacker.say_something_smart
        comment.save
      end
    end

    puts "There are now #{Comment.count} comments in the database."

    photos.each do |photo|
      users.sample(rand(users.count)).each do |user|
        like = photo.likes.build
        like.user = user
        like.save
      end
    end

    puts "There are now #{Like.count} likes in the database."

    users.each do |receiver|
      users.sample(rand(users.count)).each do |sender|
        FriendRequest.create sender: sender, receiver: receiver
      end
    end

    puts "There are now #{FriendRequest.count} friend requests in the database."
  end
end
