# frozen_string_literal: true

class AddUniqueIndexOnNameToSources < ActiveRecord::Migration[7.0]
  def change
    update_existing_sources

    change_column :sources, :name, :string, unique: true, null: false
    add_index :sources, :name, unique: true
  end

  private

  def update_existing_sources
    Source.with_discarded.group_by { |source| source.name.downcase }
                         .each do |_name, source|
      next unless source.size > 1

      source.each_with_index do |source, index|
        source.name = "#{source.name} #{index + 1}"
        source.save!(validate: false)
      end
    end
  end
end
