class ReviewsController < ApplicationController



  def index
  response = HTTParty.get('https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=d7bd4c29053c495c9845714ee487f096', {format: :json})
  @data = response['articles'][0]

  end


end

  # response = Yelp.client.search('San Francisco', { term: 'food' })
  # @yelp = response.businesses[0]
