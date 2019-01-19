require_relative '../modules/pageviews'

def pageviews_adapter(event:, context:)
    $redishost = ENV['redishost']
    $port = 6379
    pageviewscount = pageviews()
    return JSON.parse(pageviewscount)
end

