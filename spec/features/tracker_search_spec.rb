require 'spec_helper'

feature 'user can view all tracker projects' do
  scenario 'user can go to a page where a list of tracker projects are displayed' do
    visit '/'
    click_link 'View Projects'

    expect(page).to have_content "Deitrick and Kauffman’s TrackerHub"
    expect(page).to have_content 'Mike Kauffman Work'
  end

  scenario 'user can view a projects stories' do
    visit '/'
    click_link 'View Projects'
    click_on 'Mike Kauffman Work'
    expect(page).to have_content 'Building a blog'
  end

end