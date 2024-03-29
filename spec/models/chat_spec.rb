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
require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:profile) }
  end

  describe 'associations' do
    it { should belong_to(:profile) }
    it { should have_many(:messages) }
  end
end
