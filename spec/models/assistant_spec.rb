# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe Assistant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:greeting) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:chats) }
  end
end
