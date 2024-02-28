# frozen_string_literal: true

# == Schema Information
#
# Table name: servers
#
#  id         :uuid             not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :server do
    name { Faker::Internet.domain_name }
    url { Faker::Internet.url }
  end
end
