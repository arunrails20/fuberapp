# frozen_string_literal: true

# Cab model for store all cab details
class Cab < Base
  attr_accessor :id,
                :color,
                :is_available,
                :geo_location,
                :pricing,
                :vehicle_num

  @cabs = []

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
    @id = Cab.all_cabs.length + 1
    @color = params[:color]
    @is_available = params[:is_available]
    @geo_location = params[:geo_location]
    @vehicle_num = params[:vehicle_num]
  end

  def self.create(params)
    @cabs << params
  end

  def self.all_cabs
    @cabs
  end

  def self.find_by_vehicle_num(vehicle_num)
    all_cabs.find { |cab| cab.vehicle_num == vehicle_num }
  end

  def self.find_by_id(id)
    all_cabs.find { |cab| cab.id == id }
  end
end
