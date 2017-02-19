FactoryGirl.define do
  factory :token do
    expires_at "2017-02-18 22:17:16"
    token "MyString"
    association :user, factory: :user
  end
end
