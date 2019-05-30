require 'spec_helper'

RSpec.describe "User can signup" do
 it "when filling in all information" do

   visit "/signup"

   fill_in "user_name", with: "Testuser"
   fill_in "password", with: "password"
   fill_in "email", with: "example@gmail.com"
   fill_in "confirm_password", with: "password"

   click_on "Register"
   new_user = User.last

   expect(new_user.user_name).to eq("Testuser")
   expect(new_user.email).to eq("example@gmail.com")
 end
end