class DropSetsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :sets, if_exists: true
  end
end
