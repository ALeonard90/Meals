class CreateGreetings < ActiveRecord::Migration
  def change
  	create_table :greetings do |t|
  	t.string :body, null: false
  	t.integer :user_id, null:false
  	end
	end
end 