class NvidiaApi::Client
   NVIDIA_API_SERVICE = "https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/".freeze
   NVIDIA_CHEATSHEET_HOST = "https://raw.githubusercontent.com/ZenitH-AT/nvidia-data/main/".freeze

    def idLookup (platform, itemName, isGpu)
        endpoint = isGpu ? "gpu-data.json" : "os-data.json"
        res = Faraday.new(url:NVIDIA_CHEATSHEET_HOST).get(endpoint)
        resJSON = JSON.parse(res.body)
        resJSONPlat = isGpu ? resJSON[platform] : resJSON
        if isGpu
            return resJSONPlat[itemName]
        else
            item = resJSONPlat.select {|it| it['name'] == itemName}
            return item[0]['id']
        end
    end

    def listGPU
        res = Faraday.new(url:"#{NVIDIA_CHEATSHEET_HOST}gpu-data.json").get
        JSON.parse(res.body)
    end
    
    def listOs
        res = Faraday.new(url:"#{NVIDIA_CHEATSHEET_HOST}os-data.json").get
        resArr = []
        JSON.parse(res.body).each do |it|
            if it['name'].include?("Windows")
                resArr.append it['name']
            end
        end
        return resArr
    end

    def driverLookup (pfId, osId, dch)
        dchValue = dch == "true" ? "1" : "0"
        params = {
            "func" => "DriverManualLookup",
            "pfid" => pfId,
            "osID" => osId,
            "dch" => dchValue
        }
        res = Faraday.new(url: NVIDIA_API_SERVICE, params: params).get('AjaxDriverService.php?')
        JSON.parse(res.body)
    end

end
