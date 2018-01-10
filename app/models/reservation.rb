class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validate :check_overlapping_dates
	validate :check_num_guests

	enum status: [:unpaid, :paid]

	def check_overlapping_dates
		# compare this new booking againsts existing bookings
		listing.reservations.each do |old_reservation|
			if overlap?(self, old_reservation)
				if self == old_reservation
					return true
				else	
					return errors.add(:overlapping_dates, "The booking dates conflict with existing bookings")
				end
			end
		end
	end

	def overlap?(x,y)
		(x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
	end

	def check_num_guests
		max_guests = listing.guest_number
		return if num_guests < max_guests
		errors.add(:max_guests, "Max guests number exceeded")
	end

	def total_price
		price = listing.price
		num_dates = (start_date..end_date).to_a.length
		return price * num_dates
	end

end
