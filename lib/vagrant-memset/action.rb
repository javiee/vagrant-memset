require 'pathname'
require 'vagrant/action/builder'

module VagrantPlugins
  module Memset
    module Action
      include Vagrant::Action::Builtin
      
      # This action creates a new miniserver
      def self.action_up
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call,IsCreated do |env, b2|
            if !env[:result]
              b2.use MessageNotCreated
              next
            end
            b2.use ConnectMemset
            b2.use CreateServer
          end
        end
      end
      
      #It cancels a miniserver
      def self.action_destroy
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call, IsCreated do |env, b2|
            if !env[:result]
              b2.use MessageNotCreated
              next
            end
            b2.use ConnectMemset
            b2.use CancelServer
          end
        end
      end
      
      # It read miniserver state
      def self.action_read_state
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use ConnectMemset
          b.use ReadState
        end
      end
      
      
      def self.action_read_ssh_info
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use ConnectMemset
          b.use ReadSSHInfo
        end
      end
      
      
      def self.action_ssh
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call, IsCreated do |env, b2|
            if !env[:result]
              b2.use MessageNotCreated
              next
            end
            b2.use SSHExec
          end
        end
      end
      
      def self.action_ssh_run
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call, IsCreated do |env, b2|
            if !env[:result]
              b2.use MessageNotCreated
              next
            end
            b2.use SSHRun
          end
        end
      end
      
      
      def self.action_provision
        Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call, IsCreated do |env, b2|
            if !env[:result]
              b2.use MessageNotCreated
              next
            end
            b2.use Provision
            b2.use SyncFolders
          end
        end
      end
      
      action_root=Pathname.new (File.expand_path("../action",__FILE__))
      autoload :ConnectMemset, action_root.join("connect_memset")
      autoload :CreateServer, action_root.join("create_server")
      autoload :CancelServer, action_root.join("cancel_server")
      autoload :IsCreated, action_root.join("is_created")
      autoload :ReadState , action_root.join("read_state")
      autoload :ReadSSHInfo, action_root.join("read_ssh_info")
      autoload :SyncFolders, action_root.join("sync_folders")
      autoload :MessageNotCreated, action_root.join("message_not_created")
    
    end
  end
end
