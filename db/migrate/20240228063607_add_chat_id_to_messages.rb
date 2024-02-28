# frozen_string_literal: true

class AddChatIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :chat, null: false, foreign_key: true, type: :uuid
    remove_reference :messages, :profile, null: false, foreign_key: true, type: :uuid
  end
end
