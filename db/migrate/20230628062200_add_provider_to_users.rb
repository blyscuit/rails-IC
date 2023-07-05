class AddProviderToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :provider, default: "email"
      t.string :uid
    end
  end
end
