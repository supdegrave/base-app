require 'spec_helper'

describe "Admin Actions" do
  before(:each) do
    @admin = FactoryGirl.create(:admin)
    visit root_path
    click_link "Login"
    fill_in "Email", :with => @admin.email
    fill_in "Password", :with => @admin.password
    click_button "Sign in"
    click_link "Admin" 
  end

  it "shows Admin in user list on Admin page" do
    page.should have_content @admin.name
    page.should have_content "Admin"
  end

  # it "adds a new role" do
  # end
  # 
  # it "adds a new function" do
  # end
end
