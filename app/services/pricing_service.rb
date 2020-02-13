# frozen_string_literal: true

class PricingService
  attr_accessor :ride, :price, :total_min, :total_km

  def initialize(ride)
    @ride = ride
  end

  def process
    @price = price_cal
    ride.update_total_cost!(price)
    true
  rescue Exception => e
    puts "PricingService Exception:  #{e.message}"
    @price = 0
    false
  end

  private

  def price_cal
    total_min_cal
    total_km_cal

    price_config = ride.booked_cab.pricing
    (@total_min * price_config[:per_min_dogecoin]) +
      (@total_km * price_config[:per_km_dogecoin]) +
      price_config[:additional]
  end

  def total_min_cal
    @total_min = begin
                   (ride.end_date - ride.start_date) / 60
                 rescue StandardError
                   0
                 end
  end

  # TODOs move to common lib:
  def total_km_cal
    @total_km = Math.sqrt((ride.source.latitude - ride.destination.latitude)**2 + (ride.source.longitude - ride.destination.longitude)**2)
  end
end
