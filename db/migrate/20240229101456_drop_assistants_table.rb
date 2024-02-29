class DropAssistantsTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chats, :assistant, null: false, foreign_key: true, type: :uuid
    drop_table :assistants
  end
end
