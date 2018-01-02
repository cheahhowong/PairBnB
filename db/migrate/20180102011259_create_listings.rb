class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.string:name
    	t.string:place_type
    	t.string:property_type
    	t.integer:room_num
    	t.integer:bed_num
    	t.integer:guest_num
    	t.string:country
    	t.string:state
    	t.string:city
    	t.integer:zipcode
    	t.string:address
    	t.integer:price
    	t.string:description
    	t.integer:user_id

    	t.timestamps
    end
  end
end
55