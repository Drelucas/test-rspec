Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../lib/helpers/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../spec/support/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../spec/tests/*.rb'].each { |f| require f }

module ReadDriver
  def driver
    @driver ||= begin
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile.assume_untrusted_certificate_issuer = false
      profile.secure_ssl = false
      profile.native_events = true
      caps = Selenium::WebDriver::Remote::Capabilities.firefox(firefox_profile: profile)
      caps.javascript_enabled = true
      caps.platform = 'Windows'
      Selenium::WebDriver.for :firefox, profile: profile
    end
  end
end

RSpec.configure do |config|
  include ReadDriver
  include Screenshot
  include TwitterHelpers

  config.before(:all) do |_example|
    @driver = ReadDriver.driver
  end

  config.before(:suite) do
    ReadDriver.driver.manage.window.resize_to(1920, 1080)
    ReadDriver.driver.manage.timeouts.implicit_wait = 15
    if ReadDriver.driver.capabilities['webdriver.remote.sessionid']
      ReadDriver.driver.file_detector = lambda do |args|
        str = args.first.to_s
        str if File.exist?(str)
      end
    end
  end

  config.before(:each) do |_example|
    @accept_next_alert = true
    @verification_errors = []
    @driver ||= ReadDriver.driver
    @driver.manage.delete_all_cookies
  end

  config.after(:suite) do |_example|
    ReadDriver.driver.quit
  end

  config.after(:each) do |example|
    screenshot_error(example, ReadDriver.driver, 'test')
    expect(@verification_errors).to eql([])
  end
end
