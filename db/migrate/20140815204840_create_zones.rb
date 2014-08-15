class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|

      t.timestamps
    end
  end
end
