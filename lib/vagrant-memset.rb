require "pathname"

require "vagrant-memset/plugin"

module VagrantPlugins
  module Memset
    lib_path = Pathname.new(File.expand_path("../vagrant-memset",  __FILE__))
    autoload :Action, lib_path.join("action")
    autoload :Errors, lib_path.join("errors")
	  # This returns the path to the source of this plugin.
    #
    # @return [Pathname]
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end
