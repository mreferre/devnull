require_relative 'modules/getstats'

def getstats_adapter(event:, context:)
    $redishost = ENV['redishost']
    $port = 6379
    stats = getstats()
    return JSON.parse(stats)
end

