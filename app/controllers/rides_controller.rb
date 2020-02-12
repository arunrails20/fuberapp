# frozen_string_literal: true

class RidesController < ApplicationController
  def book
    # Todos update cab status
    ride_service = RideCreationService.new(params)

    if ride_service.process
      render json: { cab_number: ride_service.booked_cab_number, ride_id: ride_service.ride.id,
                     message: I18n.t('ride.success') }, status: :ok
    else
      render json: { errors: ride_service.errors.flatten }, status: :ok
    end
  end

  def start
    # update the start time
  end

  def cancel
    # update the end time
  end

  def completed
    # update the end time
  end
end
