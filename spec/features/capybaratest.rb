require_relative '../feature_helper'

feature "Going to site", :js => true do
  visit "http://www.google.com"

  sleep 20
end