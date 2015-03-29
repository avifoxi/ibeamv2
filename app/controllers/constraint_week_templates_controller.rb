class ConstraintWeekTemplatesController < ApplicationController

	def new
		@cds = ConstraintDay.all
		@cwt = ConstraintWeekTemplate.new
	end

	def index
		@cds = ConstraintDay.all
		@cwts = ConstraintWeekTemplate.all
	end

	def create
		@cwt = ConstraintWeekTemplate.new(cwt_params)
		if @cwt.save
			redirect_to constraint_week_templates_path
		else
			@cds = ConstraintDay.all
			render :new
		end
	end

	private 

	def full_params
		params.require(:constraint_week_template).permit(
			:active_starting, :name, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :max_lookahead_for_reh, :max_lookahead_for_perf, :release_unbooked_perf_lookahead
    )
	end

	def cds_from_nums
		{
			monday: ConstraintDay.find( full_params['monday']), 
			tuesday: ConstraintDay.find( full_params['tuesday']), 
			wednesday: ConstraintDay.find( full_params['wednesday']), 
			thursday: ConstraintDay.find( full_params['thursday']), 
			friday: ConstraintDay.find( full_params['friday']), 
			saturday: ConstraintDay.find( full_params['saturday']), 
			sunday: ConstraintDay.find( full_params['sunday'])
		}
	end

	def cwt_params
		full_params.slice(:active_starting, :name,:max_lookahead_for_reh, :max_lookahead_for_perf, :release_unbooked_perf_lookahead).merge(cds_from_nums)
	end


end
