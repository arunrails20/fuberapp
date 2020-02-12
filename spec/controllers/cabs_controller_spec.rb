require 'rails_helper'

RSpec.describe CabsController, type: :controller do

  describe "Get, search cab" do

    before :each do
      @request.env["CONTENT_TYPE"] = "application/json"
      prepare_test_data
    end

    context "with valid params and cab is available" do
      it "should return the available cab" do
        get :search_cabs, params: {latitude: 20, longitude: 7}
        
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["cab_details"].present?).to eq(true)
      end
    end

    context "without latitude and longitude" do
       it "should not return any cab" do
        get :search_cabs
        
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["errors"][0]).to eq("latitude and longitude both are required")
      end
    end

    context "with invalid longitude" do
      it "should not return any cab" do
        get :search_cabs, params: {latitude: 20, longitude: "test"}
        
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["errors"][0].include?("ArgumentError:")).to eq(true)
      end
    end

    context "with valid params and cab is not available" do
    end

  end

end