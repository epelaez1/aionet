class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer		:zone_id
      t.string		:network
      t.string		:network_user_id
      t.string		:network_user_name
      t.string		:network_user_email
      t.string		:token
      t.string		:secret_token
      t.timestamps
    end
  end
end
