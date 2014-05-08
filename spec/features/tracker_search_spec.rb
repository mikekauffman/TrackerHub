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

  scenario 'user can view github comments left on a project' do
    VCR.use_cassette('github_comment_features') do
      visit '/projects/1075366'
      expect(page).to have_content 'This is a test comment on what I would say is a very beautiful commit'
    end
  end
end