# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :uuid             not null
#
# Indexes
#
#  index_chats_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
FactoryBot.define do
  factory :chat do
    profile

    trait :with_message do
      after(:create) do |chat|
        create(:message, chat:)
      end
    end
  end
end
