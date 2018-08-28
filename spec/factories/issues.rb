FactoryBot.define do
  factory :issue do
    title { Faker::Name.name }
	  body { Faker::Name.name }
  end
end
