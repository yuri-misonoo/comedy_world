# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  id: '7',
  name: 'テストユーザー',
  email: 'test@test.com',
  password: 'test123',
  password_confirmation: 'test123',
  introduction: '中川家大好きです！')

Post.create!(
  user_id: '7',
  body: '中川家、サンドウィッチマン、ナイツの漫才サミット来年やったら
          絶対に行きたい！！！')

Post.create!(
  user_id: '7',
  body: 'まだ行ったことない難波グランド花月に行ってみたい！')