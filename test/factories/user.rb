FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    provider { "google_oauth2" }
    uid { Faker::Omniauth.google[:uid] }
  end
end
  