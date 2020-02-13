# frozen_string_literal: true

class RideStartService < RideService
  attr_accessor :errors

  def initialize(params)
    super(params[:id])
    @errors = []
  end

  def process
    return false unless ready_for_processing?

    ride.update_start_ride!
    ride.booked_cab.update_status!(Cab::STATES[:inprogress])
    true
    # rescue Exception => e
    #   puts "RideStartService Exception:  #{e.message}"
  end

  private

  def ready_for_processing?
    if ride.present?
      @errors << I18n.t('ride.not_eligible') unless eligible_status?
    else
      @errors << I18n.t('ride.not_found')
    end
    @errors.empty?
  end

  def eligible_status?
    Ride::START_RIDE_ELIGIBLE.map { |status| Ride::STATES[status] }.include?(ride.status)
  end
end
