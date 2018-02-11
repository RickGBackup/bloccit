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
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
  
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1,1].sample, user: users.sample) }
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

#Create comments on posts. Assign each comment a random post.
100.times do
  Comment.create!(
    user: users.sample,
    commentable: posts.sample,
    body: RandomData.random_paragraph
  )
end

#Create comments on topics. Assign each comment a random topic.
50.times do
  Comment.create!(
    user: users.sample,
    commentable: topics.sample,
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

#Create a unique Comment on Unique Post
Comment.find_or_create_by!(
  commentable: unique_post,
  body: "Unique comment on the unique post",
  user: users.sample
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
puts "#{Vote.count} votes created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"


    

