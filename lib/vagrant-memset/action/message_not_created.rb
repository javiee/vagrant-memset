module VagrantPlugins
  module Memset
    module Action
      class MessageNotCreated
        
        def initialize(app, env)
          @app = app
        end
        
        def call(env)
          env[:ui].info("Miniserver is not created")
          @app.call(env)
        end
      
      end
    end
  end
end
