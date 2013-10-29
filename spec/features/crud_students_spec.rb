require_relative '../feature_helper'
Capybara.app = StudentsController

feature "YouTube search", :js => true do
  scenario "YouTube" do
    visit 'http://www.youtube.com'
      fill_in "masthead-search-term", :with => "Chelsea Lately Miss Piggy"
    sleep 5
    click_link("Chelsea Lately: Miss Piggy")
    sleep 10
  end
end