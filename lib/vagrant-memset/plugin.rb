begin
  require "vagrant"
rescue LoadError
  raise "Memset provider must be run within vagrant"
end

#if Vagrant::Version < "1.2.0"
#   raise "Memset only runs on Vagrant 1.2.0 and above"
#end

module VagrantPlugins
  module Memset
    class Plugin < Vagrant.plugin("2")
      
      name "Memset Public Cloud"
      description <<-DESC
      This plugin enables Vagrant to manage machines in Memset Cloud.
      DESC
      
      config(:memset, :provider) do
        require_relative "config"
        Config
      end
      
      provider(:memset) do
        # Load the actual provider
        require_relative "provider"
        Provider
      end
    end
  end
end
