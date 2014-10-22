module VagrantPlugins
  module Memset
    module Action
      class CreateServer
        
        def initialize (app,env)
          @app=app
        end

        def call(env)
          #get the configs
          config = env[:machine].provider_config

          #get the pub key 
          key = env[:machine].config.ssh.private_key_path
          key = key[0] if key.is_a?(Array)
          if !key
            env[:ui].info("SSH keys not configured")
          else
            begin
              pub_key= File.read(File.expand_path("#{key}.pub",__FILE__))
            rescue Exeption => msg
              env[:ui].info("#{key}.pub file not found in the path")
              exit
            end
          end

          #create a miniserver
          server = env[:memset_compute].call("create.hourly_miniserver", {
            :sku => "#{config.sku}",
            :dry_run => "#{config.dry_run}",
            :os => "#{config.os}",
            :vlan => "#{config.vlan}",
            :pub_ssh_key => "#{pub_key}"
#            :discount_code => "#{config.discount_code}"
          })
          
          if not server["job"]
            env[:ui].info("TEST, dry_run is set to True")
            env[:ui].info("#{server}")
          else
            job_id = server["job"]["id"]
            env[:ui].info("Server is being provisioned, please wait a few minutes")
            
            while true 
              status = env[:memset_compute].call("job.status",{:id => job_id})
              break if env[:interrupted]
              break if status["finished"] == true
              env[:ui].info("Status of the server is #{status["status"]}")
              sleep 15
            end
            
            env[:machine].id = status["service"]
            env[:ui].info("Your server #{env[:machine].id} is ready")
            
            @app.call(env)
          end        
        end
      end
    end
  end
end
