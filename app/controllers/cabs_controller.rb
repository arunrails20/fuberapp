# frozen_string_literal: true

class CabsController < ApplicationController
  def search_cabs
    cab = CabSearchService.new(params[:latitude], params[:longitude])
    if cab.process
      render json: { cab_details: cab.available_cab }, status: :ok
    else
      render json: { errors: cab.errors }, status: :ok
    end
  end
end
