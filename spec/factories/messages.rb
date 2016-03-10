FactoryGirl.define do
  factory :message do
    body "MyText"
    user_conversation nil
    type 1
    sender_id 1
  end
end
