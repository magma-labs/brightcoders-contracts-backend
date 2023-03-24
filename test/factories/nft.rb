FactoryBot.define do
  factory :nft do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    image_temp { Rails.root.join('app', 'assets', 'images', 'logo.png') }
    token_id { Faker::Number.number(digits: 6) }
    ipfs_metadata { Faker::Internet.url }
    ipfs_image { Faker::Internet.url }
    student
  end
end
