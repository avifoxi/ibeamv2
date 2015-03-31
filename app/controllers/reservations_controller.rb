class ReservationsController < ApplicationController

	def new
		@reservations = Reservation.all
		@res = Reservation.new
		@blocks = ConstraintWeekTemplate::RESERVATION_BLOCKS
	end

	def create
		p '$'*80
		p 'mergey pergey'
		p "#{full_params.except(:block).merge(block_to_start_end)}"
		@res = Reservation.new(res_params)
		cwt = ConstraintWeekTemplate.current
		# p 'block_to_start_end'
		# p "#{block_to_start_end.inspect}"
		if cwt.validate(@res) 
			@res.save
			flash[:notice] = "Reservation added!"
			redirect_to new_reservation_path
		else
			@reservations = Reservation.all
			@blocks = ConstraintWeekTemplate::RESERVATION_BLOCKS
			@errors = @res.errors
			render :new
		end
	end

	private

	# reservation\"=>{\"date(1i)\"=>\"2015\", \"date(2i)\"=>\"3\", \"date(3i)\"=>\"31\", \"block\"=>\"[13, 15]\", \"is_performance\"=>\"0\"}
	def full_params
		params.require(:reservation).permit(
			:date, :block, :is_performance
    )
	end


	def block_to_start_end
		block = JSON.parse(full_params[:block])
		{
			start_time: "#{block[0]}:00",
			end_time:	"#{block[1]}:00"
		}
	end

	def res_params
		full_params.except(:block).merge(block_to_start_end)
	end

end
