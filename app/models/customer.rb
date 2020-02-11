# frozen_string_literal: true

class Customer < Base
  attr_accessor :id, :name, :mobile_number, :geo_location

  def initialize(name, mobile_number, geo_location)
    @name = name
    @mobile_number = mobile_number
    @geo_location = geo_location
  end
end
