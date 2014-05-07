require 'spec_helper'

feature 'user can view all tracker projects' do

  scenario 'user can view all projects and when they click on one, a projects stories and all their comments' do
    visit '/'
    VCR.use_cassette('features') do
      click_link 'View Projects'
      click_on 'URL Shortener'
      expect(page).to have_content 'user can easily return to the homepage'
      expect(page).to have_content 'user creates vanity url'
      expect(page).to have_content 'this is a test comment'
      expect(page).to have_content 'this is another test comment'
    end
  end

end