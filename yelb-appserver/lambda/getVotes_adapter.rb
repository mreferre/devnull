require_relative '../modules/getVotes'

def getVotes_adapter(event:, context:)
    $yelbdbhost = ENV['yelbdbhost']
    $yelbdbport = 5432
    votes = getVotes()
    return JSON.parse(votes)
end

