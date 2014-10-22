module VagrantPlugins
  module Memset
    module Action
      class IsCreated
        
        def initialize(app,env)
          @app = app
        end
        
        def call(env)
          env[:result]= :notcreated
          @app.call(env)
        end
      
      end
    end
  end
end
	
