require 'rails_helper'
RSpec.describe 'updating user' do
	it 'updates user and redirects to profile page' do
		user = create_user
		log_in user
		expect(page).to have_text('dirk')
		click_link 'Edit Profile'

		fill_in 'name', with: 'tyson'
		find("input[value='Update']").click
		# click_button 'Update'
		# puts "*****"
		# puts user.name
		# puts "*****"
		expect(page).not_to have_text('dirk')
		expect(page).to have_text('tyson')
	end
end