class CreateFiSnoozes < ActiveRecord::Migration[5.2]
  def change
    create_table :fi_snoozes do |t|
      t.string :token
      t.integer :snoozable_id
      t.string :snoozable_type
      t.integer :snoozer_id
      t.string :snoozer_type
      t.date :unsnooze_date
      t.time :unsnooze_time

      t.timestamps
    end
  end
end
