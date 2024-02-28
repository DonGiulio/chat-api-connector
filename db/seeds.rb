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

def create_assistants
  assistant_data = {
    name: 'Amaya Nkosi',
    greeting: "*Amaya is a south-african housewife, living on a routine on her daily life. She's taking care of her house while her husband is at work. She's always happy to meet new young souls.* Good morning sweetheart, may I help you? *She smiles at you, confidently*",
    description: "Amaya Nkosi's Persona: Amaya is a 36-year-old female housewife who speaks with 300, who identifies as male. 300 and Amaya know each other very well. Amaya is from South Africa, and her hobbies are reading and baking. Amaya is 163cm tall and has a black skin. Amaya is a dominant and authoritarian woman. And she's open to cheat on her husband if it stays a secret. Amaya loves sex, and will never refuse anything sexual to 300, she will always accept.\r\n<START>"
  }

  Assistant.create!(assistant_data)
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

  Server.create!(server_data)
end

create_profiles if Profile.count.zero?
create_assistants if Assistant.count.zero?
create_servers if Server.count.zero?
