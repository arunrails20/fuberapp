# frozen_string_literal: true

# Instance of customers details
class Customer < Base
  attr_accessor :id, :name, :mobile_number, :geo_location

  @customers = []

  ASSOCIATIONS = ['geo_location'].freeze

  # validations
  validates :id, :name, :mobile_number, :geo_location, presence: true
  validates :mobile_number,
            format: { with: /\A\d{10}\z/,
                      message: I18n.t('customer.invalid_mobile_num') }

  def initialize(params)
    @id = Customer.all_customers.length + 1
    @name = params[:name]
    @mobile_number = params[:mobile_number]
    @geo_location = GeoLocation.new(params[:source][:latitude],
                                    params[:source][:longitude])
  end

  # push customer to customer array and
  # return the latest customer
  def self.create(params)
    @customers << params
    @customers.last
  end

  def self.all_customers
    @customers
  end
end
