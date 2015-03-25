class ConstraintWeekTemplatesController < ApplicationController

	def new
		@cds = ConstraintDay.all
		@cwt = ConstraintWeekTemplate.new
	end

	def index
		@cds = ConstraintDay.all
	end
end
