require 'xmlrpc/client'
module VagrantPlugins
  module Memset
    module Action
      class ConnectMemset
        
        def initialize (app,env)
          @app = app
        end
        
        def call (env)

          # It connects to Memset API
          config = env[:machine].provider_config
          api_url = "https://:@api.memset.com/v1/xmlrpc".insert(8,config.api_key)
          env[:memset_compute]=XMLRPC::Client.new2(api_url)
          
          @app.call(env)
        end
      end
    end
  end
end
