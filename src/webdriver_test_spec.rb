require 'rspec'
require 'selenium-webdriver'

describe 'Chegg site' do
  before(:each) do
    # create a webdriver driver
    @driver = Selenium::WebDriver.for(:firefox)

    # navigate to Chegg site
    @driver.navigate.to 'http://www.chegg.com'
  end

  it 'should click on the Book link on topnav' do
    # click on contact book link
    @driver.find_element(:css, 'a[href$="books#rentbuy"]').click

    # print out the page title
    puts @driver.title
  end

  after(:each) do
    # finally, close the browser
    @driver.quit
  end
end