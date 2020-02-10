class Ride < Base

  attr_accessor :id, :start_date, :end_date, :status, :source, :destination, :customer_id, :cab_id, :total_cost

  @@rides = []

  def self.create(params)
  end

  
end`