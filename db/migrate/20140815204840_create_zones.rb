class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :user_id
      t.string	:zone
      t.timestamps
    end
  end
end
