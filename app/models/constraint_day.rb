class ConstraintDay < ActiveRecord::Base
	has_many :constraint_week_templates

	validates_uniqueness_of :name

	validates_presence_of :avail_starting, :avail_ending

	validates :hold_for_perf_ends, presence: true, if: :hold_for_perf_starts

	validates :hold_for_perf_starts, presence: true, if: :hold_for_perf_ends

	validate :performance_times_within_avails, if: :hold_for_perf_starts && :hold_for_perf_ends

	validate :special_hold_date_is_in_future, if: :special_hold_date

	attr_accessor :hold_performance_block, :special_hold

	private 

	def performance_times_within_avails
		unless self.hold_for_perf_starts.hour >= self.avail_starting.hour && self.hold_for_perf_ends.hour <= self.avail_ending.hour
			errors.add(:hold_performance_block, 'must fall within the available scheduling hours')
		end
	end

	def special_hold_date_is_in_future
		unless self.special_hold_date.future?
			errors.add(:special_hold_date, 'must not take effect on a past date')
		end
	end
end
