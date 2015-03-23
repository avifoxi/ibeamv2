class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :default_hrs_per_month
      t.string :username
      t.string :email

      t.timestamps null: false
    end
  end
end
