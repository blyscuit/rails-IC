class AddSearchToKeyword < ActiveRecord::Migration[7.0]
  def change
    change_table :keywords do |t|
      t.integer :ads_top_count, null: true
      t.integer :ads_page_count, null: true
      t.string :ads_top_urls, array: true, null: true
      t.integer :result_count, null: true
      t.string :result_urls, array: true, null: true
      t.integer :total_link_count, null: true
      t.string :html, null: true
      t.references :source, null: true, foreign_key: true
    end
  end
end
