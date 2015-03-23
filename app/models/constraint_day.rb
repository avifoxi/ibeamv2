class ConstraintDay < ActiveRecord::Base
	has_many :constraint_week_templates

	validates_presence_of :avail_starting, :avail_ending

	validates :hold_for_perf_ends, presence: true, if: :hold_for_perf_starts

	validates :hold_for_perf_starts, presence: true, if: :hold_for_perf_ends


	private 

	# why doesn't the below work ?

	def performance_times_within_avails
		unless :hold_for_perf_starts.hour >= :avail_starting.hour && :hold_for_perf_ends.hour <= :avail_ending.hour
			errors.add(:performance_holds, 'must fall within the available scheduling hours')
		end

	end
end
