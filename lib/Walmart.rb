require 'httparty'

class Walmart
  include HTTParty
  format :json

  base_uri 'api.walmartlabs.com/v1'

  attr_accessor :name, :wal_reviews

  def initialize(response)
    @name = response['reviews']['name']
    @wal_reviews = response['reviews']['reviewText']
  end

  def self.product_review
    response = get("/reviews/33093101?apiKey=#{ENV['walmart']}")
      if response.success?
        new(response)
      else
        raise response.response
      end
    end

  end


