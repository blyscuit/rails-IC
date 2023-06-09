class KeywordUser < ActiveRecord::Migration[7.0]
  def change
    create_table :keyword_users do |t|
      t.references :keyword, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
