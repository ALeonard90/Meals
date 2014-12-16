class CreateCans < ActiveRecord::Migration
  def change
  	create_table :cans do |t|
  	  t.integer :num_cans, null: false
  	  t.string :container, null: false
  	  t.datetime :pickup_time
  	  t.string :pickup_location, null: false
  	  t.integer :user_id, null:false
  	end 
  end
end
