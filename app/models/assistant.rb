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
class Assistant < ApplicationRecord
  has_many :chats

  validates :name, presence: true
  validates :greeting, presence: true
  validates :description, presence: true
end
