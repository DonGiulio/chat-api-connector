class AddSenderToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :sender, :string

    Message.all.each do |message|
      message.update!(sender: message.profile.name)
    end
  end
end
