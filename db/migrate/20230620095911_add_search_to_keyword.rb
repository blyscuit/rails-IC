class AddSearchToKeyword < ActiveRecord::Migration[7.0]
  def change
    change_table :keywords do |t|
      t.integer :top_ads_count, null: true
      t.integer :total_ads_count, null: true
      t.string :ads_links, array: true, null: true
      t.integer :result_count, null: true
      t.string :result_links, array: true, null: true
      t.integer :total_link_count, null: true
      t.string :html, null: true
      t.references :source, null: true, foreign_key: true
    end
  end
end
