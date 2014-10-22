require "log4r"
require "vagrant"

module VagrantPlugins
  module Memset
    class Provider < Vagrant.plugin("2", :provider)
      
      def initialize(machine)
        @machine = machine
      end
      
      def action(name)
        # Attempt to get the action method from the Action class if it
        # # exists, otherwise return nil to show that we don't support the
        # # given action.
        action_method = "action_#{name}"
        return Action.send(action_method) if Action.respond_to?(action_method)
        nil
      end
      
      def ssh_info
        env = @machine.action("read_ssh_info")
        env[:machine_ssh_info]
      end
      
      def state
        env = @machine.action("read_state")
        state_id = env[:machine_state_id]
        short = "Machine state is #{state_id}"
        long = "Machine state is #{state_id}"
        Vagrant::MachineState.new(state_id,short,long)
      end
      
      def to_s
        id = @machine.id.nil? ? "new" : @machine.id
        "MCL (#{id})"
      end
    end
  end
end
