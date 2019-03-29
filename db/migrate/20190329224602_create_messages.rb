class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.string :urlsafe, null: false
      t.integer :visits_remaining
      t.string :encryption_key

      t.timestamps null: false
    end
  end
end
