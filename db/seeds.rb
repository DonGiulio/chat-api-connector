# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
CHUNK_SIZE = 1000

def create_all(model, data)
  data.each_slice(CHUNK_SIZE) do |records|
    model.insert_all(records)
  end
end

def create_profiles
  profile_data = 100_000.times.map do
    FactoryBot.build(:profile).attributes.except('id', 'created_at', 'updated_at')
  end

  create_all Profile, profile_data
end

def create_servers
  server_data = [
    {
      name: 'Server 1',
      url: 'http://35.204.143.204:5000/v1/chat/completions'
    },
    {
      name: 'Server 2',
      url: 'http://35.204.143.204:5000/v1/chat/completions'
    }
  ]

  create_all Server, server_data
end

create_profiles if Profile.count.zero?
create_servers if Server.count.zero?
