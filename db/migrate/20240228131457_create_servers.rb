# frozen_string_literal: true

class CreateServers < ActiveRecord::Migration[7.1]
  def change
    create_table :servers, id: :uuid do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
