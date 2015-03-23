class ConstraintWeekTemplate < ActiveRecord::Base
  belongs_to :monday, class_name: 'ConstraintDay'
  belongs_to :tuesday, class_name: 'ConstraintDay'
  belongs_to :wednesday, class_name: 'ConstraintDay'
  belongs_to :thursday, class_name: 'ConstraintDay'
  belongs_to :friday, class_name: 'ConstraintDay'
  belongs_to :saturday, class_name: 'ConstraintDay'
  belongs_to :sunday, class_name: 'ConstraintDay'
end
