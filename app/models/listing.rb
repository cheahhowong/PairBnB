class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations

	mount_uploaders :photos, PhotoUploader
  	serialize :avatars, Array

  	def self.search (params)
		results = Listing.all

		results = results.where("name LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
		results = results.where("property_type LIKE ?", params[:category]) if params[:category].present?
		results = results.where("guest_number >= ?", params[:number_guest]) if params[:number_guest].present? 
		results = results.where("price >= ?", params[:min_price]) if params[:min_price].present?
		results = results.where("price <= ?", params[:max_price]) if params[:max_price].present?

		return results
	end

end
