class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :remember_digest
      t.string :ip_address
      t.string :browser

      t.timestamps null: false
    end
    add_index :sessions, [:user_id, :remember_digest]
  end
end
