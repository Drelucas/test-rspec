module Screenshot
  def screenshot_error(exa, dri, diret = '')
    if exa.exception
      FileUtils.mkdir_p 'spec/support/errors/'
      d = DateTime.now
      dt = d.strftime('%y%m%d%H%M%S').to_s
      screenshot_name = "#{diret}-#{dt}.png"
      screenshot_path = "spec/support/errors/#{screenshot_name}"
      dri.save_screenshot screenshot_path
    end
  end
end
