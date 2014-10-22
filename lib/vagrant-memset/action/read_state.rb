module VagrantPlugins
  module Memset
    module Action
      class ReadState
        
        def initialize (app,env)
          @app = app
        end
        
        def call (env)

          return "not created" if env[:machine].id.nil?
          status = env[:memset_compute].call("service.info", {:name => "#{env[:machine].id}"})
          env[:machine_state_id] = status["status"]
          if not status["status"] == "LIVE"
            env[:machine].id = nil
          end

          @app.call(env)
        end
      end
    end
  end
end
