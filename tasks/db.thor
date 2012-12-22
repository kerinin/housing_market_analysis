class GisData < Thor
  desc "push USERNAME PASSWORD", "Push data to leo (not usable outside my home network, FYI)"
  def push(username, password)
    `cd ../`
    `taps push postgres://localhost/housing_market http://#{username}:#{password}@leo.local:5000'`
  end

  desc "pull USERNAME PASSWORD", "Pull data from leo (not usable outside my home network, FYI"
  def pull(username, password)
    `cd ../`
    `taps pull postgres://localhost/housing_market http://#{username}:#{password}@leo.local:5000'`
  end
end
