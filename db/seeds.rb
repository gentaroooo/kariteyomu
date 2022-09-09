10.times do
  User.create(
      name: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: '12345678',
      password_confirmation: '12345678'
  )
end

100.times do |index|
  Book.create(
      user: User.offset(rand(User.count)).first,
      title: "タイトル#{index}",
      body: "本文#{index}"
  )
end