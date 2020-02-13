# frozen_string_literal: true

class CabSearchService
  attr_accessor :latitude, :longitude, :errors, :available_cab, :shortest_distance, :color

  def initialize(latitude, longitude, color = nil)
    @latitude = latitude
    @longitude = longitude
    @available_cab = nil
    @errors = []
    @shortest_distance = Float::INFINITY
    @color = color
  end

  def process
    return false unless ready_for_processing?

    nearest_cab
    true
  rescue Exception => e
    puts "CabSearchService Exception:  #{e.message}"
  end

  private

  def ready_for_processing?
    validate_params
    return false if errors.present?

    errors.empty?
  end

  def nearest_cab
    Cab.available_cabs(color).each do |cab|
      distance = calculate_distance(cab.geo_location)
      if distance < shortest_distance
        @shortest_distance = distance
        @available_cab = cab
      end
    end
  end

  def validate_params
    if latitude.present? && longitude.present?
      convert_to_float
    else
      @errors << I18n.t('cab.invalid_geo_location')
    end
  end

  def convert_to_float
    @latitude = Float(latitude)
    @longitude = Float(longitude)
  rescue ArgumentError => e
    @errors << 'ArgumentError: (' + e.message + ')'
  rescue TypeError => e
    @errors << 'TypeError: (' + e.message + ')'
  end

  def calculate_distance(cab)
    Math.sqrt((latitude - cab.latitude)**2 + (longitude - cab.longitude)**2)
  end
end
