require 'json'
require 'socket'
require 'pg'
require 'pg_ext'
require_relative 'restaurantsdbread'
require_relative 'restaurantsdbupdate'

def getVotes()
        outback = restaurantsdbread("outback")
        ihop = restaurantsdbread("ihop")
        bucadibeppo = restaurantsdbread("bucadibeppo")
        chipotle = restaurantsdbread("chipotle")
        votes = '[{"name": "outback", "value": ' + outback + '},' + '{"name": "bucadibeppo", "value": ' + bucadibeppo + '},' + '{"name": "ihop", "value": '  + ihop + '}, ' + '{"name": "chipotle", "value": '  + chipotle + '}]'
        return votes
end