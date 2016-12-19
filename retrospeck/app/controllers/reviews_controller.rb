class ReviewsController < ApplicationController

  def index
  #news_api
  response = HTTParty.get('https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=d7bd4c29053c495c9845714ee487f096', {format: :json})
  @data = response['articles'][0]
  # yelp
  params = {term: 'starbucks'}
  res = Yelp.client.search('New York', params)
  @yelp = res.businesses[0].snippet_text
  #twitter
  @tweet = $twitter.user_timeline("realdonaldtrump", count: 10)
  end

end
