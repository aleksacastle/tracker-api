require 'faker'
USERS = [
		[ "user1", "user1@email.com", false, "123456" ],
		[ "user2", "user2@email.com", false, "qwerty"],
		[ "manager", "manager@email.com", true, "password" ]
].freeze

USERS.each do |name, email, manager, password|
	User.create!(name: name, manager: manager, email: email, password: password)
end

15.times do
	Issue.create!(
			title: Faker::Friends.character,
			body: Faker::Friends.quote,
			status: 'pending',
			user_id: User.find_by_name("user1")[:id]
	)
end

2.times do
	Issue.create!(
			title: Faker::Superhero.name,
			body: Faker::Matz.quote,
			status: 'pending',
			user_id: User.find_by_name("user2")[:id]
	)
end