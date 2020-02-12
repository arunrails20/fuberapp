# frozen_string_literal: true

class GeoLocation < Base
  attr_accessor :latitude, :longitude

  # validations
  validates :latitude, :longitude, presence: true, numericality: true

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
end
