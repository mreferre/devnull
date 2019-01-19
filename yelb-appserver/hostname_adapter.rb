require_relative 'modules/hostname'

def hostname_adapter(event:, context:)
    hostnamedata = hostname()
    return hostnamedata
end

