require_relative 'modules/restaurant'

def restaurant_adapter(event:, context:)
    $yelbdbhost = ENV['yelbdbhost']
    $yelbdbport = 5432
    restaurantname = event['pathParameters']['restaurant']
    restaurantcount = restaurantsupdate(restaurantname)
    { statusCode: 200, body: restaurantcount }
end
