# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :uuid             not null, primary key
#  content    :text
#  sender     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :uuid             not null
#
# Indexes
#
#  index_messages_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    sender { Faker::Name.name }
    profile
  end
end
