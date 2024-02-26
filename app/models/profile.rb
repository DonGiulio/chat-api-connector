# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  category   :string
#  gender     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validates :name, :category, presence: true
end
