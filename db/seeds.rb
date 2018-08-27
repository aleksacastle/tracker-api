require 'faker'
USERS = [
		[ "user1", "user1@email.com", "user", "123456" ],
		[ "user2", "user2@email.com", "user", "qwerty"],
		[ "manager", "manager@email.com", "manager", "password" ]
].freeze

USERS.each do |name, email, role, password|
	User.create!(name: name, role: role, email: email, password: password)
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