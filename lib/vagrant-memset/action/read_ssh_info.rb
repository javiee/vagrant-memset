require 'pp'
module VagrantPlugins
  module Memset
    module Action
      class ReadSSHInfo
        
        def initialize (app,env)
          @app = app
        end
        
        def call(env)

          return "not created" if env[:machine].id.nil?
          print env[:machine].id
          env[:machine_ssh_info] = {
            :host => "#{env[:machine].id}.miniserver.com",
            :port => 22,
            :username => "root"
          }
          
          @app.call(env)
        end
      end
    end
  end
end
