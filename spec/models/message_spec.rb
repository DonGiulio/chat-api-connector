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
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:profile_id) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:sender) }
  end
end
