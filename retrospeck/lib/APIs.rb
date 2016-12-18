# require 'HTTParty'

# class ApiCall
#   def get_news
#     uri = 'https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=d7bd4c29053c495c9845714ee487f096'
#     HTTParty.get(uri, :query => {:DeveloperKey => d7bd4c29053c495c9845714ee487f096})
#     @json_hash = response.parsed.response
#     return @json_hash
#   end

# end
