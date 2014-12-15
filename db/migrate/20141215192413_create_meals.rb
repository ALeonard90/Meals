class CreateMeals < ActiveRecord::Migration
  def change
  	create_table :meals do |t|
  	  t.text :name, null: false
  	  t.text :will_feed, null: false
  	  t.text :pickup_date, null: false
  	  t.text :pickup_time, null: false
  	  t.text :pickup_location, null: false
  	  
  end
end
