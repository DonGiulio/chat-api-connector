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
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:chat) }
    it { is_expected.to have_one(:profile).through(:chat) }
  end

  describe 'default_scope' do
    it 'orders by created_at in ascending order' do
      expect(described_class.all.to_sql).to include('ORDER BY "messages"."created_at" ASC')
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:sender) }
    it { is_expected.to validate_presence_of(:chat) }
    it { is_expected.to validate_presence_of(:role) }
  end
end
