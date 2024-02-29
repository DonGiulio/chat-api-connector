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

module Faker
  module Category
    class << self
      def name
        categories.sample
      end

      def categories
        @@categories ||= ::File.readlines(Rails.root.join('spec/support/fixtures/categories_list.txt')).map(&:chomp)
      end
    end
  end
end

FactoryBot.define do
  factory :profile do
    gender { %i[male female].sample }
    category { Faker::Category.name }

    after(:build) do |profile|
      first_name = profile.gender == 'male' ? Faker::Name.male_first_name : Faker::Name.female_first_name
      profile.name = "#{first_name} #{Faker::Name.last_name}"
    end
  end
end
