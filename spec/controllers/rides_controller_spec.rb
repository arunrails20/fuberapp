# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RidesController, type: :controller do
  describe 'Post, Book cab' do
    before :each do
      @request.env['CONTENT_TYPE'] = 'application/json'
      prepare_test_data
    end

    context 'Create new Ride with valid params' do
      let(:params) do
        { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455,
          source: { "latitude": 19, "longitude": 8 },
          destination: { "latitude": 91, "longitude": 8 } }
      end

      it 'should return success message and cab number' do
        post :book, body: params.to_json, format: :json

        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['cab_number']).to eq(params[:vehicle_num])
        expect(parsed_response['message']).to eq(I18n.t('ride.success'))
      end
    end

    context 'Invalid params source and destinations are missing' do
      let(:params) { { vehicle_num: 'KA 10 2010', name: 'arun', mobile_number: 9_911_224_455, source: {}, destination: {} } }

      it 'should return error message' do
        post :book, body: params.to_json, format: :json

        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors'].present?).to eq(true)
      end
    end

    context 'Invalid params - vehicle_num is missing' do
      let(:params) do
        { vehicle_num: '', name: 'arun', mobile_number: 9_911_224_455,
          source: { "latitude": 19, "longitude": 8 },
          destination: { "latitude": 19, "longitude": 8 } }
      end

      it 'should return error message' do
        post :book, body: params.to_json, format: :json

        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(["Cab can't be blank"])
      end
    end
  end
end
