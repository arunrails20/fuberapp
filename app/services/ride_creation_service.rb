# frozen_string_literal: true

class RideCreationService
  attr_accessor :ride, :errors

  attr_reader :params

  def initialize(params)
    @ride = nil
    @params = params
    @errors = []
  end

  def process
    return false unless ready_for_processing?

    ride.booked_cab.update_status!(Cab::STATES[:initiated])
    true
  rescue Exception => e
    puts "RideCreationService Exception:  #{e.message}"
  end

  def booked_cab_number
    ride.booked_cab.vehicle_num
  end

  private

  def ready_for_processing?
    customer = create_customer
    return false unless errors.empty?

    create_ride(customer.id)
    errors.empty?
  end

  # create new customer record if validations fails will
  # push all the errors to the errors attributes
  def create_customer
    customer = Customer.new(params)
    if customer.push_errors.empty?
      Customer.create(customer)
    else
      @errors << customer.push_errors
    end
  end

  # create new ride record
  def create_ride(customer_id)
    cab_id = Cab.find_by_vehicle_num(params[:vehicle_num]).try(:id)
    ride = Ride.new(cab_id: cab_id, customer_id: customer_id,
                    source: params[:source],
                    destination: params[:destination])

    if ride.push_errors.empty?
      @ride = Ride.create(ride)
    else
      @errors << ride.push_errors
    end
  end
end
