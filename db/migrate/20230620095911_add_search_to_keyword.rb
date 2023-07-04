# frozen_string_literal: true

class AddSearchToKeyword < ActiveRecord::Migration[7.0]
  def change
    change_table :keywords do |t|
      t.integer :ads_top_count, default: 0, null: false
      t.integer :ads_page_count, default: 0, null: false
      t.string :ads_top_urls, array: true, null: true
      t.integer :result_count, default: 0, null: false
      t.string :result_urls, array: true, null: true
      t.integer :total_link_count, default: 0, null: false
      t.string :html, null: true
      t.string :status, default: 'in_progress', null: false

      t.references :source, null: true, foreign_key: true
    end
  end
end
