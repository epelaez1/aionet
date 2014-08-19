class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :user_id
      t.string :network
      t.string :category
      t.text :network_token
      t.text :network_verifier
      t.timestamps
    end
  end
end
