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
    completed: 4,
    available: 5
  }.freeze

  STATES.each do |k, v|
    define_method("#{k}?") do
      status == v
    end
  end

  AVAILABLE_STATUS = %i[available completed].freeze
  NOT_AVAILABLE_STATUS = %i[initiated inprogress].freeze

  @cabs = []

  def initialize(params)
    @id = Cab.all.length + 1
    @status = STATES[:available]
    @color = params[:color]
    @geo_location = params[:geo_location]
    @vehicle_num = params[:vehicle_num]
  end

  def self.create(params)
    @cabs << params
  end

  def self.all
    @cabs
  end

  def self.available_cabs(color = nil)
    if color
      all.select { |cab| cab.color == color && AVAILABLE_STATUS.any? { |status| cab.send(status.to_s + '?') } }
    else
      all.select { |cab| AVAILABLE_STATUS.any? { |status| cab.send(status.to_s + '?') } }
    end
  end

  def self.find_by_vehicle_num(vehicle_num)
    all.find { |cab| cab.vehicle_num == vehicle_num }
  end

  def self.find_by_id(id)
    all.find { |cab| cab.id == id }
  end

  def update_status!(status)
    self.status = status
  end
end
