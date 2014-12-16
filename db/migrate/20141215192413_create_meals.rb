class CreateMeals < ActiveRecord::Migration
  def change
  	create_table :meals do |t|
  	  t.string :name, null: false
  	  t.integer :will_feed, null: false
  	  t.datetime :pickup_time
  	  t.string :pickup_location, null: false
  	  t.integer :user_id, null:false
  	end 
  end
end
