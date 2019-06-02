require 'spec_helper'

RSpec.describe "micro learning" do
  include Rack::Test::Methods

  test_user = {user_name: "test", email: "test@gmail.com", password: "test_password", confirm_password: "test_password" }
  def app
      MicroLearningApp.new
  end
  it "gets the home page" do
    get "/"
    expect(last_response).to be_ok
  end

  it "gets the login page" do
    get "/login"
    expect(last_response).to be_ok
  end

  it "gets the signup page"  do
    get "/signup"
    expect(last_response).to be_ok
  end

  it "redirects after signup" do 
    post "/signup" , test_user
    expect(last_response).to be_redirect
    expect(User.last.user_name).to eq("test")
  end

  it "should login user" do
    post "/signup", test_user
    post "/login", test_user
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.path).to eq("/categories")
    end

  it "should not login non existant users" do
    post "/signup", test_user
    wrong_user = {password: test_user[:password], user_name: "none"}
    post "login", wrong_user
    expect(last_response.body).to include("wrong password or username")
  end

  it "should not login with wrong password" do
    post "/signup", test_user
    wrong_user = {password: "none", user_name: test_user[:user_name]}
    post "login", wrong_user
    expect(last_response.body).to include("wrong password or username")
  end

  it "should not get categories if no user is logged in" do
    get "/categories"
    expect(last_response.body).to include("kindly log in")
  end

  it "should get categories if user is logged in" do
    post "/signup", test_user
    post "/login", test_user
    get "/categories"
    expect(last_response).to be_ok
    expect(last_response.body).to include("categories") 
  end

  it "should not get results if user is not logged in" do 
    get "/results"
    expect(last_response.body).to include("kindly log in")
  end

  it "should get results if user is logged in" do
    post "/signup", test_user
    post "/login", test_user
    get "/results"
    expect(last_response).to be_ok
    expect(last_response.body).to include("Results")
  end
end