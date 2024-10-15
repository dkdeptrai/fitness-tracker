class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.string :uid, null: false, default: ""
      t.boolean :allow_password_change, default: false
      t.json :tokens
    end

    add_index :users, :uid, unique: true
  end
end
