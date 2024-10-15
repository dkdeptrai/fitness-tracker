class AddProviderToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :provider, :string, null: false, default: 'email'

    add_index :users, [:uid, :provider], unique: true
  end
end
