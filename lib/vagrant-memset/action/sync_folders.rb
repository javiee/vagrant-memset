require "log4r"
require 'rbconfig'
require "vagrant/util/subprocess"

module VagrantPlugins
  module Memset
    module Action
      class SyncFolders
        
        def initialize(app,env)
          @app = app
        end
        
        def call(env)
          
          @app.call(env)
          ssh_info = env[:machine].ssh_info
          config = env[:machine].provider_config
          env[:machine].config.vm.synced_folders.each do |id, data|
            hostpath  = File.expand_path(data[:hostpath], env[:root_path])
            guestpath = data[:guestpath]
            hostpath = "#{hostpath}/" if hostpath !~ /\/$/
            env[:ui].info("Syncing folders: \n Host: #{hostpath} \n Guest: #{guestpath}")
            env[:machine].communicate.sudo("mkdir -p '#{guestpath}'")
            env[:machine].communicate.sudo("chown -R #{ssh_info[:username]} '#{guestpath}'")
            command = ["rsync", "--verbose", "--archive", "--compress", "--delete","-e","ssh -p #{ssh_info[:port]} -i '#{ssh_info[:private_key_path][0]}' -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null",hostpath,"#{ssh_info[:username]}@#{ssh_info[:host]}:#{guestpath}"]
            r = Vagrant::Util::Subprocess.execute(*command)
            if r.exit_code != 0
              raise Errors::RsyncError,
                :guestpath => guestpath,
                :hostpath => hostpath,
                :stderr => r.stderr
            end
          end
        end
      end
    end
  end
end

