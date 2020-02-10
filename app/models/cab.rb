class Cab < Base

  attr_accessor :id, :color, :is_available, :geo_location, :pricing

  @@cabs = []

  def self.create(params)
    @@cabs << params
  end

  def self.all_cabs
    @@cabs
  end
end