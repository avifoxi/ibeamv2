class CreateConstraintWeekTemplates < ActiveRecord::Migration
  def change
    create_table :constraint_week_templates do |t|
      t.integer :max_lookahead_for_reh
      t.integer :max_lookahead_for_perf
      t.integer :release_unbooked_perf_lookahead, default: 30
      t.date :active_starting,                    default: Date.today
      
      t.references :monday, index: true, foreign_key: true
      t.references :tuesday, index: true, foreign_key: true
      t.references :wednesday, index: true, foreign_key: true
      t.references :thursday, index: true, foreign_key: true
      t.references :friday, index: true, foreign_key: true
      t.references :saturday, index: true, foreign_key: true
      t.references :sunday, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
