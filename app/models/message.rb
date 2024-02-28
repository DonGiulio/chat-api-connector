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
class Message < ApplicationRecord
  belongs_to :chat
  has_one :profile, through: :chat

  default_scope { order(created_at: :asc) }

  validates :chat, :content, :sender, :role, presence: true
end
