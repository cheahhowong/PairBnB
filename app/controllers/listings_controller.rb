class ListingsController < ApplicationController
	before_action :show_listing_params, only: [:show, :edit, :update, :destroy]

	def show
		@user=User.find(@listing.user_id)
		@reservation = Reservation.where(user_id: current_user.id)
		render 'listings/show'
	end

	def new
		render '/listings/new'
	end

	def create
		@user = User.find(current_user.id)
		@newlisting = Listing.new(listing_params)
		@newlisting.save
		@listing = Listing.where(id: current_user.id)
		redirect_to user_show_path(@user.id)
	end

	def edit
		render 'listings/edit'
	end

	def update
		@user = User.find(current_user.id)
		@listing.update(listing_params)
		show_listing_params
		redirect_to listing_path(@user.id)
	end

	def destroy
		@user = User.find(current_user.id)
		@listing.destroy
		redirect_to user_show_path(@user.id)
	end

	private

	def show_listing_params
		@listing = Listing.find(params[:id])
	end

	def listing_params
		params.require(:listing).permit(:name, :place_type, :property_type, :room_number, 
			:bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, {photos:[]})
	end

end
