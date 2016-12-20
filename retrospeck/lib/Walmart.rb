require 'httparty'

class Walmart
  include HTTParty
  format :json

  base_uri 'api.walmartlabs.com'

  attr_accessor :reviews :name

  def initialize(response)
    @name = response['reviews']['name']
    @reviews = response['reviews'][0]['reviewText']
  end

  def self.product_review(name, reviews)
    get("/v1/reviews/33093101?apiKey=#{ENV['walmart']}")
