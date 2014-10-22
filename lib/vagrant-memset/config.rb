require "vagrant"

module VagrantPlugins
  module Memset
    class Config < Vagrant.plugin("2", :config)
      
      #Memset api key
      attr_accessor :api_key
      
      #Memset vps model
      attr_accessor :sku
      
      # Image
      attr_accessor :os
      
      # Discount code
      attr_accessor :discount_code

      # Vlan name
      attr_accessor :vlan
      
       # Test run
       attr_accessor :dry_run
      
      def initialize
        @api_key = UNSET_VALUE
        @sku = UNSET_VALUE
        @os = UNSET_VALUE
        @discount_code = UNSET_VALUE
        @vlan = UNSET_VALUE
      	@dry_run = UNSET_VALUE
      end
      
      def finalize!
        @api_key = nil if api_key == UNSET_VALUE
        @sku = nil if @sku == UNSET_VALUE
        @os = nil if @os == UNSET_VALUE
        @discount_code = nil if @discount == UNSET_VALUE
        @vlan = nil if @vlan == UNSET_VALUE
        @dry_run = /True/ if @dry_run == UNSET_VALUE	
        
      end
        
        def validate (machine)
          errors = []
          { "Memset Provider" => errors }
      end
    end
  end
end
