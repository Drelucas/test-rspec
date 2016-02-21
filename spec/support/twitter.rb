require 'webdriver_helper'

class Twitter
  attr_accessor :driver

  def initialize(data)
    self.driver = data
  end

  def url_twitter
    @driver.get("https://twitter.com/")
  end

  def login
    @driver.find_element(:id, "signin-email").click
    @driver.find_element(:id, "signin-email").clear
    @driver.find_element(:id, "signin-email").send_keys "your username"
    @driver.find_element(:id, "signin-password").clear
    @driver.find_element(:id, "signin-password").send_keys "your password"
    @driver.find_element(:xpath, "//button[@type='submit']").click
  end

  def logout
    @driver.find_element(:id, "user-dropdown-toggle").click
    @driver.find_element(:css, "#signout-button > button.dropdown-link").click
  end

  def text_user
    @driver.find_element(:css, "span.u-linkComplex-target").text
  end

  def click_text_twitter
    @driver.find_element(:css, "div.tweet-content div#tweet-box-home-timeline.tweet-box.rich-editor.notie").click
    @driver.find_element(:id, "tweet-box-home-timeline").click
  end

  def fill_twitter(text)
    @driver.find_element(:id, "tweet-box-home-timeline").clear
    @driver.find_element(:id, "tweet-box-home-timeline").send_keys text
  end

  def twittar_disable?
    element = @driver.find_element(:xpath, "(//button[@type='button'])[23]")
    puts element.attribute('disabled')
    if element.attribute('disabled')
      true
    else
      false
    end
  end

  def click_twittar
    @driver.find_element(:xpath, "(//button[@type='button'])[23]").click
  end

  def text_posted
    @driver.find_element(:css, "div.content p.TweetTextSize.js-tweet-text.tweet-text").text
  end
end
