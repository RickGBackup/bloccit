require 'random_data'

#Create Users
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
    )
end
users = User.all

#Create Topics
15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
    )
end
topics = Topic.all

#Create Posts
50.times do
  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

#Create Sponsored Posts
50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: rand(1000)
  )
end

#Create comments. Assign each comment a random post.
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#Assignment 34
#Create a unique Post
unique_post = Post.find_or_create_by!(
  title: "Unique Post Numero Uno",
  body: "This post should be unique",
  user: users.sample,
  topic: topics.sample
)

#Create a unique Comment
Comment.find_or_create_by!(
  post: unique_post,
  body: "Unique comment on the unique post"
  )

#Create random Advertisements
100.times do 
  Advertisement.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_price
  )
end

#Create random Questions
100.times do 
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
  )
end

#Create an admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
  )
#Create a member user
member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  role: 'member'
  )
  
#Create a moderator
moderator = User.create!(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  role: 'moderator'
  )


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"


    

