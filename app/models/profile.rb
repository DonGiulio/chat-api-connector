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
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validates :name, :category, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[category gender]
  end
end
