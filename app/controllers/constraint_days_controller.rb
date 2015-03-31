class ConstraintDaysController < ApplicationController

	def new 
		@cd = ConstraintDay.new
	end

	def create
		# p '*'*80
		# p 'params'
		# p "#{params}"
		@cd = ConstraintDay.new(name: full_params[:name])

		if @cd.update_attributes(time_params)
			redirect_to constraint_days_path
		else
			render 'new'
		end
	end

	private 

	def full_params
		params.require(:constraint_day).permit(
			:avail_starting, :avail_ending, :hold_for_perf_starts, :hold_for_perf_ends, :name, :block_whole_day, :special_hold_date, :hold_performance_block, :special_hold
    )
	end

	def time_params
		puts 'inside times method'
		return_obj = {
			avail_starting: "#{full_params['avail_starting(4i)']}:00", 
			avail_ending: "#{full_params['avail_ending(4i)']}:00"
		}
		if full_params['special_hold'] == '1'
			return_obj[:special_hold_date] = "#{full_params['special_hold_date(1i)']}-#{full_params['special_hold_date(2i)']}-#{full_params['special_hold_date(3i)']}"
		end
		if full_params['hold_performance_block'] == '1'
			return_obj[:hold_for_perf_starts] = "#{full_params['hold_for_perf_starts(4i)']}:00"
			return_obj[:hold_for_perf_ends] = "#{full_params['hold_for_perf_ends(4i)']}:00 "
		end
		return_obj
	end


end
