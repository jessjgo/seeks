class SessionsController < ApplicationController
	def new
		render '/sessions/new'
	end
	def create
		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = ["Invalid combination!"]
			redirect_to '/sessions/new'
		end
	end
	def destroy
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end
end