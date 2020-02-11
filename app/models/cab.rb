class Cab < Base

  attr_accessor :id, :color, :is_available, :geo_location, :pricing, :vehicle_num

  def initialize(params)
    @color = params[:color]
    @is_available = params[:is_available]
    @geo_location = params[:geo_location]
    @pricing = params[:pricing]
  end

  @@cabs = []

  def self.create(params)
    @@cabs << params
  end

  def self.all_cabs
    @@cabs
  end

end