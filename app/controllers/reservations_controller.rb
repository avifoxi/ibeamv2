class ReservationsController < ApplicationController

	def new
		@reservations = Reservation.all
		@res = Reservation.new
		@blocks = ConstraintWeekTemplate::RESERVATION_BLOCKS
	end

	def create
		p '$'*80
		p 'params sss'
		p "#{params.inspect}"

		# Reservation perhaps validates itself for no overlapping reservations
		# cwt then validates against constraints 

		cwt = ConstraintWeekTemplate.current
		cwt.validate(@res) 
	end

end
