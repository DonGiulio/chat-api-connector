# frozen_string_literal: true

class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants, id: :uuid do |t|
      t.string :name
      t.text :greeting
      t.text :description

      t.timestamps
    end
  end
end
