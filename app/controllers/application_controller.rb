# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :accept_only_json

  def accept_only_json
    return if request.content_type == 'application/json'

    render json: { message: I18n.t('general.invalid_content_type') }, status: 406
  end
end
