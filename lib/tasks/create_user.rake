require 'securerandom'

namespace :user do
  desc 'Create a new user with email and provider, and auto-generate a UID'
  task :create, %i[email provider] => :environment do |t, args|
    email = args[:email]
    provider = args[:provider]
    uid = SecureRandom.uuid

    if email.present? && provider.present?
      user = User.new(email: email, provider: provider, uid: uid)

      if user.save
        puts "User with email '#{email}' and UID '#{uid}' created successfully."
      else
        puts "Error creating user: #{user.errors.full_messages.join(', ')}"
      end
    else
      puts "Usage: rake user:create['email@example.com','provider']"
    end
  end
end
