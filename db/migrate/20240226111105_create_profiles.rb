class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :name
      t.integer :gender
      t.string :category

      t.timestamps
    end
  end
end
