class BraintreeController < ApplicationController
  
  	def new
  		@client_token = Braintree::ClientToken.generate
  		@listing = Listing.find_by(id: params[:listing_id])
  		@reservation = Reservation.find_by(id: params[:id])

  	end

  	def checkout
	  	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  	@price = Listing.find_by(id: params[:listing_id]).price
	  	@num_dates = Reservation.find_by(id: params[:id])
	  	@total_dates = (@num_dates.start_date..@num_dates.end_date).to_a.length
		total_price = @price * @total_dates	

	  	result = Braintree::Transaction.sale(
	   	:amount => total_price, #this is currently hardcoded
	   	:payment_method_nonce => nonce_from_the_client,
	   	:options => {
	      	:submit_for_settlement => true
	    	}
	   	)
	  	byebug
	  	if result.success?
	  		@user=User.find(current_user.id)
	  		@listing=Listing.where(user_id: @user.id)
	  		@booking = @user.reservations
			@reservation = Reservation.where(user_id: @user.id )
	  		@paymentstatus = Reservation.find_by(id: params[:id])
	  		byebug
	  		@paymentstatus.update(status: "paid")
	    	render 'users/show', :flash => { :success => "Transaction successful!" }
	    	
	  	else
	    	redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
	  	end
	end

end
