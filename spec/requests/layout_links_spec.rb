require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "casa")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "contato")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "conceito")
  end

   it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "conectar")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should # fill in
    click_link "Contact"
    response.should # fill in
    click_link "Home"
    response.should # fill in
    click_link "Sign up now!"
    response.should # fill in
  end
end

describe "when not signed in" do
    
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end

     it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")
  end
end