# == Schema Information
#
# Table name: chats
#
#  id           :uuid             not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  assistant_id :uuid             not null
#  profile_id   :uuid             not null
#
# Indexes
#
#  index_chats_on_assistant_id  (assistant_id)
#  index_chats_on_profile_id    (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (assistant_id => assistants.id)
#  fk_rails_...  (profile_id => profiles.id)
#
class Chat < ApplicationRecord
  belongs_to :profile
  belongs_to :assistant
  has_many :messages, dependent: :destroy

  validates :profile, presence: true
  validates :assistant, presence: true
end
