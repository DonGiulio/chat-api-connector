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
class Server < ApplicationRecord
  validates :name, :url, presence: true

  default_scope { order(created_at: :asc) }
end
