require 'rspec'
require 'selenium-webdriver'

describe 'Newtours site' do
  before(:each) do
    # Set wait time to 10 seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    # create a webdriver driver for FireFox
    @driver = Selenium::WebDriver.for(:firefox)

    # Use the below driver for chrome (must do additional steps to get this to work):
    # @driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]

    # navigate to Newtours site
    @driver.navigate.to 'http://newtours.demoaut.com'
  end

  it 'should check the Sign-On link on Home lands on correct page' do
    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    @wait.until { @driver.find_element(:name, 'login')}

    # get the page's title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  it 'should be able to sign into the site from the Sign-On page' do
    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    @wait.until { @driver.find_element(:name, 'login')}

    # Type into the Username and Password fields:
    @driver.find_element(:name, 'userName').send_key 'AndrewD'
    @driver.find_element(:name, 'password').send_key 'testtest'
    @driver.find_element(:name, 'login').click

    #wait until the ITINERARY link is displayed, then check the page title
    @wait.until { @driver.find_element(:link, 'ITINERARY')}

    #Get and verify the page title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Find a Flight: Mercury Tours:'
  end

  it 'should be able to sign into the site from the Home page' do
    # Type into the Username and Password fields on the Home page:
    @driver.find_element(:name, 'userName').send_key 'AndrewD'
    @driver.find_element(:name, 'password').send_key 'testtest'
    @driver.find_element(:name, 'login').click

    #wait until the ITINERARY link is displayed, then check the page title
    @wait.until { @driver.find_element(:link, 'ITINERARY')}

    #Get and verify the page title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Find a Flight: Mercury Tours:'

  end

  it 'should be able to sign into the site from the Find-A-Flight page' do
    if @driver.find_elements(:link, 'SIGN-OFF').empty?
      # Click on the Flights link and wait until the Flight finder page is loaded
      @driver.find_element(:link, 'Flights').click
      @wait.until { @driver.find_element(:link, 'Register here')}
      # Verify that we are on the Flight-Finder page
      expect(@driver.title).to be == 'Welcome: Mercury Tours'
      # Type into the Username and Password fields on the Flight Finder page:
      @driver.find_element(:name, 'userName').send_key 'AndrewD'
      @driver.find_element(:name, 'password').send_key 'testtest'
      @driver.find_element(:name, 'login').click

      #wait until the ITINERARY link is displayed, then check the page title
      @wait.until { @driver.find_element(:link, 'ITINERARY')}

      #Get and verify the page title
      pageTitle = @driver.title
      expect(pageTitle).to be == 'Find a Flight: Mercury Tours:'

      #Click to signout
      @driver.find_element(:link, 'SIGN-OFF').click
    else
      #Click to signout
      @driver.find_element(:link, 'SIGN-OFF').click
      #Wait until the SIGN-ON link is found, then click on the Flights link and wait until the Flight finder page is loaded
      @wait.until {@driver.find_element(:link, 'SIGN-ON')}
      @driver.find_element(:link, 'Flights').click
      @wait.until { @driver.find_element(:link, 'Register here')}
      # Verify that we are on the Flight-Finder page
      expect(@driver.title).to be == 'Welcome: Mercury Tours'
      # Type into the Username and Password fields on the Flight Finder page:
      @driver.find_element(:name, 'userName').send_key 'AndrewD'
      @driver.find_element(:name, 'password').send_key 'testtest'
      @driver.find_element(:name, 'login').click

      #wait until the ITINERARY link is displayed, then check the page title
      @wait.until { @driver.find_element(:link, 'ITINERARY')}

      #Get and verify the page title
      pageTitle = @driver.title
      expect(pageTitle).to be == 'Find a Flight: Mercury Tours:'

      #Click to signout
      @driver.find_element(:link, 'SIGN-OFF').click
    end
  end

  it 'should be able to sign out of the site from the Flight-Finder page' do
    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    @wait.until { @driver.find_element(:name, 'login')}

    # Type into the Username and Password fields:
    @driver.find_element(:name, 'userName').send_key 'AndrewD'
    @driver.find_element(:name, 'password').send_key 'testtest'
    @driver.find_element(:name, 'login').click

    #wait until the ITINERARY link is displayed, then check the page title
    @wait.until { @driver.find_element(:link, 'ITINERARY')}

    #Get and verify the page title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Find a Flight: Mercury Tours:'

    #Sign out of the site from the Flight Finder page:
    @driver.find_element(:link, 'SIGN-OFF').click

    #wait until the SIGN-ON link is shown again
    @wait.until { @driver.find_element(:link, 'SIGN-ON')}

    #Get and verify the page title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  it 'should not be able to sign into the site from the Sign-On page with wrong password' do
    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    @wait.until { @driver.find_element(:name, 'login')}

    # Type into the Username and Password fields:
    @driver.find_element(:name, 'userName').send_key 'AndrewD'
    @driver.find_element(:name, 'password').send_key 'wrong_pass'
    @driver.find_element(:name, 'login').click

    #Get and verify the page title after a 5-second wait
    sleep(3)
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  it 'should not be able to sign into the site from the Sign-On page with wrong username' do
    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    @wait.until { @driver.find_element(:name, 'login')}

    # Type into the Username and Password fields:
    @driver.find_element(:name, 'userName').send_key 'Andrew'
    @driver.find_element(:name, 'password').send_key 'testtest'
    @driver.find_element(:name, 'login').click

    #Get and verify the page title after a 5-second wait
    sleep(3)
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  it 'should not be able to sign into the site from the Home page with wrong password' do
    # Type into the Username and Password fields on the Home page:
    @driver.find_element(:name, 'userName').send_key 'AndrewD'
    @driver.find_element(:name, 'password').send_key 'wrongpwd'
    @driver.find_element(:name, 'login').click

    #Get and verify the page title after a 5-second wait
    sleep(3)
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  it 'should not be able to sign into the site from the Home page with wrong username' do
    # Type into the Username and Password fields on the Home page:
    @driver.find_element(:name, 'userName').send_key 'Andrew'
    @driver.find_element(:name, 'password').send_key 'testtest'
    @driver.find_element(:name, 'login').click

    #Get and verify the page title after a 5-second wait
    sleep(3)
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  after(:each) do
    # finally, close the browser
    @driver.quit
  end
end