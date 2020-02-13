# frozen_string_literal: true

class RideService
  attr_accessor :ride

  def initialize(id)
    @ride = Ride.find_by_id(id)
  end
end
