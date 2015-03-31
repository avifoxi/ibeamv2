class Reservation < ActiveRecord::Base
  belongs_to :user

  attr_accessor :block

  validates_presence_of :date, :start_time, :end_time
  validates_uniqueness_of [:start_time, :end_time], scope: :date
end
