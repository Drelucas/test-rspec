module TwitterHelpers
  def twitter
    @twitter ||= Twitter.new(@driver)
  end
end
