require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    # disable creation of favoriteby, and initial email to, user who creates post - for ease of testing with a new post
    Post.any_instance.stub(:create_favorite)
    Post.any_instance.stub(:send_email_notification)
  end
  
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
  
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }
  
  #Shoulda tests
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }   #Make sure it's not disallowing a reasonable email
  
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end
 
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
 
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end
  
  describe "roles" do
    it "is member by default" do
      expect(user.role).to eq("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end
    
    context "admin user" do
      before do
        user.admin!
      end
 
      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
 
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
    
  describe "invalid user" do  #Testing for 'true negatives', to ensure that it catches values we know shouldn't pass.
    let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
    let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }
 
    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end
 
    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
  
  describe "Name format" do
    let(:user_lower_case_name) { User.new(name: "james dean", email: "user1@bloccit.com", password: "abcdef") }
    let(:user_upper_case_name) { User.new(name: "JAMES DEAN", email: "user2@bloccit.com",  password: "abcdef") }
    
    it "should be camel case after saving" do
      user_lower_case_name.save
      expect(User.last.name).to eq("James Dean")
  
      user_upper_case_name.save
      expect(User.last.name).to eq("James Dean")
    end
  end
  
  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end
 
    it "returns `nil` if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end
 
    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create  #create a favorite belonging to user and @post
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
end
