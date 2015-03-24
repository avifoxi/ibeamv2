class ConstraintDaysController < ApplicationController

	def new 
		@cd = ConstraintDay.new
	end

	def create
		p '*'*80
		p 'params'
		p "#{params}"
		@cd = ConstraintDay.new(full_params)
		p '*'*80
		p 'initialized cd'
		p "#{@cd.inspect}"
		p 'valid?'
		p "#{@cd.valid?}"

		p 'errors'
		p "#{@cd.errors.inspect}"

		p "full ps"
		p "#{full_params.inspect}"

		p '*'*80
		p 'testing times from full_params'
		p "#{time_params.inspect}"

	end



# hours of 24 =>  \"avail_starting(4i)\"=>\"10\", 
# mins of 60 => \"avail_starting(5i)\"=>\"53\", 

# hours of 24 => \"avail_ending(4i)\"=>\"20\", 
# mins of 60 => \"avail_ending(5i)\"=>\"53\",


	private 

	def full_params
		params.require(:constraint_day).permit(
			:avail_starting, :avail_ending, :hold_for_perf_starts, :hold_for_perf_ends, :name, :block_whole_day, :special_hold_date, :hold_performance_block, :special_hold
    )
	end

	def time_params
		puts 'inside times method'
		return_obj = {
			avail_starting: Time.new("#{full_params['avail_starting(4i)']}:00"), 
			avail_ending: Time.new("#{full_params['avail_ending(4i)']}:00")
		}
		if full_params['special_hold'] == '1'
			return_obj[:special_hold_date] = full_params[:special_hold_date]
		end
		if full_params['hold_performance_block'] == '1'
			return_obj[:hold_for_perf_starts] = full_params[:hold_for_perf_starts]
			return_obj[:hold_for_perf_ends] = full_params[:hold_for_perf_ends]
		end
		return_obj
	end


end
