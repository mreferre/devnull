require 'redis'
require 'aws-sdk-dynamodb'

def pageviews()
        if defined?($yelbddbcache) 
                dynamodb = Aws::DynamoDB::Client.new
                params = {
                    table_name: $yelbddbcache,
                    key: {
                        counter: pageviews
                    }
                }
                pageviewsitem = dynamodb.get_item(params)
                pageviewscount = pageviewsitem[count]
                pageviewscount += 1 
                params = {
                        table_name: $yelbddbcache,
                        key: {
                            counter: pageviews
                        },
                        update_expression: 'set count = :c',
                        expression_attribute_values: {':c' => pageviewscount},
                        return_values: 'UPDATED_NEW'
                }
                pageviewscount = dynamodb.update_item(params)
        else 
                puts $redishost
                redis = Redis.new
                redis = Redis.new(:host => $redishost, :port => 6379)
                redis.incr("pageviews")
                pageviewscount = redis.get("pageviews")
                redis.quit()
        end
        return pageviewscount
end