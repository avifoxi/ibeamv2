class ConstraintWeekTemplate < ActiveRecord::Base
  belongs_to :monday, class_name: 'ConstraintDay'
  belongs_to :tuesday, class_name: 'ConstraintDay'
  belongs_to :wednesday, class_name: 'ConstraintDay'
  belongs_to :thursday, class_name: 'ConstraintDay'
  belongs_to :friday, class_name: 'ConstraintDay'
  belongs_to :saturday, class_name: 'ConstraintDay'
  belongs_to :sunday, class_name: 'ConstraintDay'

  validates_presence_of :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :max_lookahead_for_reh, :max_lookahead_for_perf

  validates :max_lookahead_for_perf, :max_lookahead_for_reh, :numericality => { :greater_than_or_equal_to => 1 }
  # validate :active_today_or_future, 

  private

  def active_today_or_future
  	unless (self.active_starting +1).today? || self.active_starting.future? 
			errors.add(:special_hold_date, 'must not take effect on a past date')
		end
	end

end
