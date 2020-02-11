# frozen_string_literal: true

class GeoLocation < Base
  attr_accessor :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
end
