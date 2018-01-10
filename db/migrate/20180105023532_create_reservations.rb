class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
    	t.date :start_date
    	t.date :end_date
    	t.integer :num_guests
    	t.integer :user_id
    	t.integer :listing_id

      t.timestamps
    end
  end
end
