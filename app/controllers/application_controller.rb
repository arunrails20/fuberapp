# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :accept_only_json

  def accept_only_json
    return if request.content_type == 'application/json'

    render json: { msg: 'Content-Type should be application/json' }, status: 406
  end
end
