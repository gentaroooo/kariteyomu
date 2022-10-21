# 100.times do
#   User.create(
#     name: Faker::Games::Pokemon.name,
#     email: Faker::Internet.email,
#     password: '12345678',
#     password_confirmation: '12345678'
#   )
# end

# 90.times do |index|
#   Book.create(
#     user: User.offset(rand(User.count)).first,
#     title: Faker::Book.title,
#     published_date: '1976',
#     systemid: '4033280103'
#   )
# end

# 10.times do |index|
#   Post.create(
#     user: User.offset(rand(User.count)).first,
#     title: Faker::Book.title,
#     published_date: '2022-05-01',
#     body: Faker::Lorem.sentence,
#   )
# end

# 10.times do |index|
#   Book.create(
#     user: User.offset(rand(User.count)).first,
#     title: 'はらぺこあおむし',
#     published_date: '1976',
#     info_link: 'http://books.google.co.jp/books?id=BhXmAQAACAAJ&dq=%E3%81%AF%E3%82%89%E3%81%BA%E3%81%93%E3%81%82%E3%81%8A%E3%82%80%E3%81%97&hl=&source=gbs_api1',
#     image_link: 'http://books.google.com/books/content?id=BhXmAQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
#     systemid: '4033280103'
#   )
# end

# 10.times do |index|
#   Post.create(
#     user: User.offset(rand(User.count)).first,
#     title: 'あやしいぶたのたね',
#     published_date: '2022-05-01',
#     body: "タイトル#{index}",
#     info_link: 'http://books.google.co.jp/books?id=nvtzyAEACAAJ&dq=%E3%81%B6%E3%81%9F%E3%81%AE%E3%81%9F%E3%81%AD&hl=&source=gbs_api',
#     image_link: 'http://books.google.com/books/content?id=nvtzyAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
#   )
# end

# User.create!(
#   name: "test",
#   email: "a@yahoo.co.jp",
#   password: 'test555',
#   password_confirmation: 'test555'
# )

# 90.times do |index|
#   Book.create(
#     user: User.find_by(name: "test"),
#     title: Faker::Book.title,
#     published_date: '1976',
#     systemid: '4033280103'
#   )
# end

# 10.times do |index|
#   Book.create(
#     user: User.find_by(name: "test"),
#     title: 'はらぺこあおむし',
#     published_date: '1976',
#     info_link: 'http://books.google.co.jp/books?id=BhXmAQAACAAJ&dq=%E3%81%AF%E3%82%89%E3%81%BA%E3%81%93%E3%81%82%E3%81%8A%E3%82%80%E3%81%97&hl=&source=gbs_api1',
#     image_link: 'http://books.google.com/books/content?id=BhXmAQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
#     systemid: '4033280103'
#   )
# end

Category.create([
  { name: '笑える' },
  { name: 'たのしい' },
  { name: 'おばけ' },
  { name: 'かわいい' },
  { name: 'かなしい' },
  { name: 'ともだち' },
  { name: 'かぞく' },
  { name: 'しぜん' },
  { name: '知育' },
])