# frozen_string_literal: true

class RidesController < ApplicationController
  def book
    ride_service = RideCreationService.new(params)

    if ride_service.process
      render json: { cab_number: ride_service.booked_cab_number, ride_id: ride_service.ride.id,
                     message: I18n.t('ride.success') }, status: :ok
    else
      render json: { errors: ride_service.errors.flatten }, status: :ok
    end
  end

  def start
    service = RideStartService.new(params)

    if service.process
      render json: { message: I18n.t('ride.ride_start') }, status: :ok
    else
      render json: { errors: service.errors.flatten }, status: :ok
    end
  end

  def end
    service = RideCompleteService.new(params)

    if service.process
      # After successfull ride completed update cab as available
      service.ride.booked_cab.update_status!(Cab::STATES[:available])

      # Update Cab location
      destination = service.ride.destination
      service.ride.booked_cab.update_location!(destination.latitude, destination.longitude)

      pricing_service = PricingService.new(service.ride)
      pricing_service.process

      render json: { message: I18n.t('ride.ride_end'),
                     pricing: { total_amt: pricing_service.price,
                                total_min: pricing_service.total_min,
                                total_km: pricing_service.total_km } }, status: :ok
    else
      render json: { errors: service.errors.flatten }, status: :ok
    end
  end
end
