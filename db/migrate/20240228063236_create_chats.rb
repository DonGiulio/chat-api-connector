# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.references :assistant, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
