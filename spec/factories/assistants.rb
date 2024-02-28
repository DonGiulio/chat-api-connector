# == Schema Information
#
# Table name: assistants
#
#  id          :uuid             not null, primary key
#  description :text
#  greeting    :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :assistant do
    name { Faker::Name.name }
    greeting { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end
