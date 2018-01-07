class UsersController < Clearance::UsersController
	before_action :find_user, only: [:show, :edit, :update, :destroy] 

	def index
		@listing = Listing.order(updated_at: :desc).page params[:page]
		render 'layouts/homepage'
	end

	def create
		@listing = Listing.order(updated_at: :desc).page params[:page]
		@user = User.new(user_params)
		@user.save
		render 'layouts/homepage'
	end

	def show
		@booking = @user.reservations
		@listing = Listing.where(user_id: params[:id])
		@reservation = Reservation.where(user_id: params[:id] )
		render 'users/show'
	end

	def edit
		render 'users/edit'
	end

	def update
		@booking = @user.reservations
		@user.update(user_params)
		@reservation = Reservation.where(user_id: params[:id])
		@listing = Listing.where(user_id: params[:id])
		render 'users/show'
	end

	def destroy

	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, {photos:[]} )
	end

end