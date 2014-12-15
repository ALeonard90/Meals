class Meal < ActiveRecord::Base
	# validates :name, presence: true
	# validates :will_feed, presence: true,
	# numericality: true,
	# validates :pickup_date, presence: true,
	# validates :pickup_time, presence: true,
	# validates :pickup_location, presence: true,
	# validates :user_id, presence: true

	belongs_to :user

end