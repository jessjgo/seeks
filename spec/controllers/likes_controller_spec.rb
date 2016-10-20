require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
		user = create_user
		secret = user.secrets.create(content: "secret")
		@like = user.likes.create(user: user, secret: secret)
	end
	describe "when not logged in" do
		before do
			session[:user_id] = nil
		end
		it "cannot access create" do
			post :create
			expect(response).to redirect_to('/sessions/new')
		end
		it "cannot access destroy" do
			delete :destroy, id: @like
		end
	end
	describe "when signed in as the wrong user" do
		before do
			@wrong_user = create_user 'mike', 'mike@stars.com'
			session[:user_id] = @wrong_user.id
			# @like = user.likes.create(user: user, secret: secret)
		end
		it "cannot access destroy" do
			visit '/secrets'
			expect(page).not_to have_button('Unlike')
			# delete :destroy, user_id: user, secret_id: secret
			# expect(response).to redirect_to("/users/#{@wrong_user.id}")
		end
	end
end