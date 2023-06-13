class Keyword < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :user, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
