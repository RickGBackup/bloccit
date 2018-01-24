require 'random_data'

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
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

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
  body: "This post should be unique"
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

puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"


  


    

