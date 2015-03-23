class ConstraintDay < ActiveRecord::Base
	has_many :constraint_week_templates

	validates_presence_of :avail_starting, :avail_ending

	validates :hold_for_perf_ends, presence: true, if: :hold_for_perf_starts

	validates :hold_for_perf_starts, presence: true, if: :hold_for_perf_ends

	validate :performance_times_within_avails, if: :hold_for_perf_starts && :hold_for_perf_ends

	private 

	def performance_times_within_avails
		unless self.hold_for_perf_starts.hour >= self.avail_starting.hour && self.hold_for_perf_ends.hour <= self.avail_ending.hour
			errors.add(:performance_holds, 'must fall within the available scheduling hours')
		end

	end
end
