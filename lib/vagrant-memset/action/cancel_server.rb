module VagrantPlugins
  module Memset
    module Action
      class CancelServer
        
        def initialize (app, env)
          @app = app
        end
        
        def call(env)

          if env[:machine].id
            server = env[:memset_compute].call("service.cancel",{ :name => "#{env[:machine].id}"})
            env[:ui].info("#{env[:machine].id} has been CANCELLED")
            env[:machine].id = nil
          end

        @app.call(env)
        end
      end
    end
  end
end





