class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.boolean :is_performance
      t.boolean :fee_is_processed

      t.timestamps null: false
    end
  end
end
