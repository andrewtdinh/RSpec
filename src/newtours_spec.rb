require 'rspec'
require 'selenium-webdriver'

describe 'Newtours site' do
  before(:each) do
    # create a webdriver driver
    @driver = Selenium::WebDriver.for(:firefox)

    # navigate to Newtours site
    @driver.navigate.to 'http://newtours.demoaut.com'
  end

  it 'should check the Sign-On link on Home lands on correct page' do
    # Set wait time to 10 seconds
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    # click on Sign-On link
    @driver.find_element(:link, 'SIGN-ON').click

    wait.until { @driver.find_element(:name, 'login')}
    # get the page's title
    pageTitle = @driver.title
    expect(pageTitle).to be == 'Sign-on: Mercury Tours'
  end

  after(:each) do
    # finally, close the browser
    @driver.quit
  end
end