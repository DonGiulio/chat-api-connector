# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :uuid             not null, primary key
#  content    :text
#  role       :string
#  sender     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :uuid             not null
#
# Indexes
#
#  index_messages_on_chat_id  (chat_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#
FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    sender { Faker::Name.name }
    chat
  end
end
