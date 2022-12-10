class NvidiaController < ApplicationController
    def index
        nvid_client = NvidiaApi::Client.new
        gpu_id = nvid_client.idLookup(params['platform'], params['gpu'], true)
        os_id = nvid_client.idLookup(params['platform'], params['os'], false)
        @driverInfo = nvid_client.driverLookup(gpu_id, os_id, params['isDch'])
    end


end
