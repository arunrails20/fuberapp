# frozen_string_literal: true

class Ride < Base
  attr_accessor :id,
                :start_date,
                :end_date,
                :status,
                :source,
                :destination,
                :customer_id,
                :cab_id,
                :total_cost

  # validations
  validates :id, :status, :source, :destination,
            :customer_id, :cab_id, presence: true

  @rides = []

  ASSOCIATIONS = %w[source destination].freeze

  START_RIDE_ELIGIBLE = [:initiated].freeze

  # states configuration
  STATES = {
    initiated: 1,
    inprogress: 2,
    cancelled: 3,
    completed: 4
  }.freeze

  STATES.each do |k, v|
    define_method("#{k}?") do
      status == v
    end
  end

  def initialize(params)
    params = params.with_indifferent_access
    @id = Ride.all.length + 1
    @status = STATES[:initiated]
    @source = GeoLocation.new(params[:source][:latitude],
                              params[:source][:longitude])
    @destination = GeoLocation.new(params[:destination][:latitude],
                                   params[:destination][:longitude])
    @customer_id = params[:customer_id]
    @cab_id = params[:cab_id]
  end

  def self.create(params)
    @rides << params
    @rides.last
  end

  def self.all
    @rides
  end

  def booked_cab
    Cab.find_by_id(cab_id)
  end

  def self.find_by_id(id)
    all.find { |ride| ride.id == id }
  end

  def update_start_ride!
    self.start_date = Time.now
    self.status = STATES[:inprogress]
  end
end
