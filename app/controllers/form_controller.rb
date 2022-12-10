class FormController < ApplicationController
    def index
        nvid_client = NvidiaApi::Client.new
        gpu_list = nvid_client.listGPU
        @os_list = nvid_client.listOs
        @gpu_desktop = gpu_list['desktop'].keys
        @gpu_notebook = gpu_list['notebook'].keys
    end
end
