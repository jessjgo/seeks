class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def new
		render 'users/new'
	end
	def create
		@user = User.new(email: params[:email], name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to '/users/new'
		end
	end
	def show
		@user = User.where(id: params[:id]).first
		# puts @user
		@secrets = @user.secrets
		@secrets_liked = @user.secrets_liked
		render 'users/show'
	end
	def edit
		@user = User.where(id: params[:id]).first
		render 'users/edit'
	end
	def update
		@user = User.where(id: params[:id]).first
		if @user.update(email: params[:email], name: params[:name])
			flash[:success] = "User info successfully updated!"
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/users/#{@user.id}/edit"
		end
	end
	def destroy
		user = User.where(id: params[:id]).first.destroy
		session[:user_id] = nil
		redirect_to "/sessions/new"
	end
end
