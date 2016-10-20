require 'rails_helper'
RSpec.describe 'creating a user' do
	before do
		visit '/users/new'
		# save_and_open_page
	end
	it 'creates new user and redirects to profile page with proper credentials' do
		fill_in 'email', with: 'dirk@mavs.com'
		fill_in 'name', with: 'Dirk'
		fill_in 'password', with: 'password'
		fill_in 'password_confirmation', with: 'password'
		find("input[value='Join']").click
		last_user = User.last
		puts "hello"
		puts current_path
		puts last_user
		puts "end"
		expect(current_path).to eq("/users/#{last_user.id}")
	end
	it 'shows validation errors without proper credentials' do
		find("input[type='submit'], input[value='Join']").click
		expect(current_path).to eq('/users/new')
		expect(page).to have_text('Password can\'t be blank')
		expect(page).to have_text('Email is invalid')
	end
end