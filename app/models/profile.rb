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
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats

  validates :name, :category, presence: true

  def greeting
    "Hello, I'm #{name}. Today I feel like #{category}, what can we talk about?"
  end

  def context
    "#{name} is a #{gender}, Today #{male? ? 'he' : 'she'} feels like #{category}, and looking to explore this feeling with 300. Happy to explore anything."
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category gender]
  end
end
