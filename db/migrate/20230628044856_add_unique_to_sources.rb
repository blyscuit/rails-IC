class AddUniqueToSources < ActiveRecord::Migration[7.0]
  def change
    change_column :sources, :name, :string, unique: true, null: false
    add_index :sources, :name, unique: true
  end
end
