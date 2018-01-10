class ReservationsController < ApplicationController

	def new
		@listing = Listing.find_by(id: params[:listing_id])
		@reservation = Reservation.new
		render "reservations/new"
	end

	def create
		@user = User.find_by(id: current_user.id)
		@new_reservation = Reservation.new(reservation_params)
		if @new_reservation.save
			@listing = Listing.where(user_id: @user.id)
			@booking = @user.reservations
			@reservation = Reservation.where(user_id: @user.id)
			render "users/show" 
		else
			p @new_reservation.errors
			flash[:error] = "Date chosen is booked!"
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		@new_reservation = Reservation.find(params[:id])
		@new_reservation.destroy
		@user = User.find_by(id: current_user.id)
		@booking = @user.reservations
		@listing = Listing.where(user_id: @user.id)
		@reservation = Reservation.where(user_id: @user.id)
		render "users/show"
	end


	private

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :num_guests, :user_id, :listing_id)
	end

end
