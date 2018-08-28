FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Name.name }
    password { 'password' }
  end
end
