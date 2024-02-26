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

# enable reclaiming of memory after block is run
begin
  profile_data = 100_000.times.map do
    FactoryBot.build(:profile).attributes.except('id', 'created_at', 'updated_at')
  end

  create_all Profile, profile_data
end
