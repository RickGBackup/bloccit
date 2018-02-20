FactoryGirl.define do
  factory :comment do
    body RandomData.random_paragraph
    user
    association :commentable, factory: :post
  end
end