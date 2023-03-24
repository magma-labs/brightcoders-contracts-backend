FactoryBot.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    second_surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    wallet_address { Faker::Blockchain::Ethereum.address }
  end
end
