class CabSearchService
  attr_accessor :latitude, :longitude, :errors, :available_cab, :shorest_distance

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
    @available_cab = nil
    @errors = []
    @shorest_distance = 0
  end

  #TODOs Exception handling for process
  def process
    return false unless ready_for_processing?

    Cab.all_cabs.each do |cab|
      distance = calculate_distance(cab.geo_location)
      if shorest_distance < distance
        @shorest_distance = distance
        @available_cab = cab
      end
    end
    true
  end

  private

  def ready_for_processing?
    validate_params
    return false if errors.present?

    errors.empty?
  end

  def validate_params
    unless latitude.present? && longitude.present?
      @errors << "latitude and longitude both are required"
    else
      convert_to_float
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
    Math.sqrt((latitude - cab.latitude)** 2 + (longitude - cab.longitude)** 2)
  end

end
