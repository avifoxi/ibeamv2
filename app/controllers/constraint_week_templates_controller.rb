class ConstraintWeekTemplatesController < ApplicationController

	def new
		@cds = ConstraintDay.all
		@cwt = ConstraintWeekTemplate.new
	end
end
