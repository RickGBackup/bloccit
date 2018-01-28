require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
  
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
end
