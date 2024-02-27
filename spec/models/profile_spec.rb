# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  category   :string
#  gender     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'gender enum' do
    it 'defines a gender enum with the correct values' do
      expect(Profile.genders.keys).to match_array(%w[male female])
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      profile = Profile.new(name: 'John Doe', category: 'Category 1', gender: :male)
      expect(profile).to be_valid
    end

    it 'is not valid without a name' do
      profile = Profile.new(category: 'Category 1', gender: :male)
      expect(profile).not_to be_valid
      expect(profile.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a category' do
      profile = Profile.new(name: 'Jane Doe', gender: :male)
      expect(profile).not_to be_valid
      expect(profile.errors[:category]).to include("can't be blank")
    end

    it 'raises an ArgumentError with an invalid gender' do
      expect do
        Profile.new(name: 'Jane Doe', category: 'Category 1', gender: 'unknown')
      end.to raise_error(ArgumentError, "'unknown' is not a valid gender")
    end
  end
end
