10.times do
  User.create(
      name: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: '12345678',
      password_confirmation: '12345678'
  )
end

20.times do |index|
  Book.create(
      user: User.offset(rand(User.count)).first,
      title: "タイトル#{index}",
      body: "本文#{index}"
  )
end

20.times do |index|
Post.create(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    body: "本文#{index}"
  )
end

Category.create([
  { name: '0歳' },
  { name: '1歳' },
  { name: '2歳' },
  { name: '3歳' },
  { name: '4歳' },
  { name: '5歳' },
  { name: '6歳' },
  { name: '大人' },
])