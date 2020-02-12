# frozen_string_literal: true

class CabsController < ApplicationController
  def search_cabs
    cab = CabSearchService.new(params[:latitude],
                               params[:longitude],
                               params[:color])

    if cab.process
      if cab.available_cab
        render json: { cab_details: cab.available_cab }, status: :ok
      else
        render json: { message: I18n.t('cab.not_available') }, status: :ok
      end
    else
      render json: { errors: cab.errors }, status: :ok
    end
  end
end
