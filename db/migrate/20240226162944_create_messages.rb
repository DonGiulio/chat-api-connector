# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :content
      t.references :profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
