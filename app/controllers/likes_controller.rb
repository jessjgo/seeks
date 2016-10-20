class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
	# before_action :require_correct_user, only: [:create, :destroy]

	def create
		secret = Secret.where(id: params[:secret_id]).first
		like = Like.create(user_id: current_user.id, secret_id: params[:secret_id])
		# puts like.valid?
		redirect_to '/secrets'
	end
	def destroy
		like = Like.where(user_id: current_user.id, secret_id: params[:secret_id]).first.destroy
		# puts like.valid?
		redirect_to '/secrets'
	end
end