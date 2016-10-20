class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]

	def index
		@secrets = Secret.all
		render 'secrets/index'
	end
	def create
		secret = Secret.new(content: params[:content], user: current_user)
		# using above will return user object
		# use user_id: current_user...it is available to use through method in application controller
		# can also just user user_id: session[:user_id]
		if secret.save
			redirect_to current_user
		end
	end
	def destroy
		# secret = Secret.where(id: params[:id]).first.destroy
		# redirect_to current_user
		secret = Secret.where(id: params[:id]).first
		secret.destroy if secret.user == current_user
		# only allow owner of secret to delete his/her secret
		redirect_to "/users/#{current_user.id}"
	end
end