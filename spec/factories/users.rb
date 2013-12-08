# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "Test #{n}"}
    last_name 'User'
    sequence(:email) {|n| "example#{n}@example.com"}
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now

    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
