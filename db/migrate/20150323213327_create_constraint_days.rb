class CreateConstraintDays < ActiveRecord::Migration
  def change
    create_table :constraint_days do |t|
      t.time :avail_starting
      t.time :avail_ending
      t.time :hold_for_perf_starts
      t.time :hold_for_perf_ends
      t.string :name
      t.boolean :is_special_hold
      t.date :special_hold_date

      t.timestamps null: false
    end
  end
end
