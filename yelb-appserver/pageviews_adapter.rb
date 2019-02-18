require_relative 'modules/pageviews'

def pageviews_adapter(event:, context:)
    headers 'Access-Control-Allow-Origin' => '*'
    headers 'Access-Control-Allow-Headers' => 'Authorization,Accepts,Content-Type,X-CSRF-Token,X-Requested-With'
    headers 'Access-Control-Allow-Methods' => 'GET,POST,PUT,DELETE,OPTIONS'
    content_type 'application/json'
    $redishost = ENV['redishost']
    $port = 6379
    pageviewscount = pageviews()
    # use the return JSON command when you want the API Gateway to manage the http communication  
    # return JSON.parse(pageviewscount)
    { statusCode: 200, body: pageviewscount }
end

