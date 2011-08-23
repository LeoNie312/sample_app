require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "should have a signup page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up")
  end
  
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
    
    #for fun
    it "should not have a signout link" do
      visit root_path
      response.should_not have_selector("a", :href => signout_path,
                                             :content => "Sign out")
    end
    #for fun
    
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      integration_sign_in @user
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
    
    
    #this part is for exercise
    describe "when non-admin users" do
      #by default the admin status is false, no need to
      #change anything
      
      it "should not have 'delete' shown on the page" do
        visit users_path
        response.should_not have_selector('a', :content=>'delete')
      end
    end
        
    describe "when admin users" do
      
      it "should have 'delete' shown on the page" do
        @user.toggle!(:admin)
        visit users_path
        response.should have_selector('a', :content=>'delete')
      end
    end
    #this part is for exercise
    
    
  end
  
end