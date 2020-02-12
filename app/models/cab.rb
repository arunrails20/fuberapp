# frozen_string_literal: true

# Cab model for store all cab details
class Cab < Base
  attr_accessor :id,
                :color,
                :is_available,
                :geo_location,
                :pricing,
                :vehicle_num,
                :status

  # states configuration
  STATES = {
    initiated: 1,
    inprogress: 2,
    cancelled: 3,
    completed: 4,
    available: 5
  }.freeze

  STATES.each do |k, v|
    define_method("#{k}?") do
      status == v
    end
  end

  AVAILABLE_STATUS = %i[available cancelled completed].freeze
  NOT_AVAILABLE_STATUS = %i[initiated inprogress].freeze

  @cabs = []

  def initialize(params)
    @id = Cab.all_cabs.length + 1
    @status = STATES[:available]
    @color = params[:color]
    @geo_location = params[:geo_location]
    @vehicle_num = params[:vehicle_num]
  end

  def self.create(params)
    @cabs << params
  end

  def self.all_cabs(color = nil)
    if color
      @cabs.select { |cab| cab.color == color && AVAILABLE_STATUS.any? { |status| cab.send(status.to_s + '?') } }
    else
      @cabs.select { |cab| AVAILABLE_STATUS.any? { |status| cab.send(status.to_s + '?') } }
    end
  end

  def self.find_by_vehicle_num(vehicle_num)
    all_cabs.find { |cab| cab.vehicle_num == vehicle_num }
  end

  def self.find_by_id(id)
    all_cabs.find { |cab| cab.id == id }
  end
end
