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
  
  validate :active_today_or_future 

  ## TODOS -- must validate that active_starting + active ending never overlap -- orrrrr -- if i've not set an active_ending in my old cwt, and create a new cwt whose active_starting overlaps -- throw error. and if you proceed -- set active_ending on old date

  # hard code start + end times of all blocks
  RESERVATION_BLOCKS = [['7am to 9am', [7,9] ], ['9am to 11am', [9,11]], ['11am to 1pm',[11,13]], ['1pm to 3pm', [13,15]], ['3pm to 5pm', [15,17]],['5pm to 7pm', [17,19]],['7pm to 9pm', [19,21]],['9pm to 11pm', [21,23]]]

  
  def self.current
    # Person.where(["user_name = :u", { u: user_name }]).third
    # ConstraintWeekTemplate.where(active_ending: nil) 
    # placeholder method -- this must return last cwt where active starting is before today, and active ending has not yet occured or is nil
    ConstraintWeekTemplate.last
  end

  def validate(reservation)
    unless reservation.valid?
      return false
    end

    special_hold = ConstraintDay.find_by(special_hold_date: reservation.date)

    if special_hold
      unless self.valid_against_cd?(reservation, special_hold)
        return false
      end
    end
    # Date::DAYNAMES[r.date.wday] => 'Sunday'
    dayname = Date::DAYNAMES[reservation.date.wday].downcase
    constraint_day = self.send(dayname)
    unless self.valid_against_cd?(reservation, constraint_day)
      return false
    end
    true
    # p 'dayname'
    # p "#{dayname.inspect}"
    # p 'constraint_day'
    # p "#{constraint_day.inspect}"
  end

  # r =  Reservation.new(date: '2015-4-19', start_time: '09:00', end_time: '21:00')

  def valid_against_cd?(res, cd)
    if cd.block_whole_day
      res.errors.add(:constraint_day, "the full day is blocked to rentals")
      return false
    end
    unless res.start_time.hour >= cd.avail_starting.hour && res.end_time.hour <= cd.avail_ending.hour
      res.errors.add(:constraint_day, "invalid against reservation contraints")
      return false
    end
    if cd.hold_for_perf_starts
      unless res.start_time.hour >= cd.hold_for_perf_starts.hour && res.end_time.hour <= cd.hold_for_perf_ends.hour
        res.errors.add(:constraint_day, "must not book within performance block hold")
        return false
      end
    end
    true
  end

  private

  def active_today_or_future
  	unless (self.active_starting + 1.day).today? || self.active_starting.future? 
			errors.add(:active_starting, 'must not take effect on a past date')
		end
	end

  

end
