## Vagrant Provider for Memset's Public Cloud 

This plugin adds [Vagrant](http://www.vagrantup.com)  compatibility for [Memset API](http://www.memset.com/apidocs/) including the following features:

* Create [cloud instances](http://www.memset.com/cloud/compute/)
* Cancel instances.
* Authentication via SSH.
* Support for sync folders 
* Provisioning via built-in vagrant provisioners.

This plugin is based on existing Provider plugins

## Installation

* Download and install [Vagrant](https://www.vagrantup.com/downloads.html)
```
vagrant plugin install vagrant-memset
vagrant up --provider=memset
```
Installing vagrant-memset requires "make" package installed.

## Configuration

 Parameters supported by  Vagrant Memset Provider:

* `api_key` (String) - API key for accessing Memset. It requires access  server.info, create.hourly_minisever,job.status,service.cancel methods. 
* `sku` - The SKU of the service  to be provisioned.
* `os` (String) - The Operating System. Only linux.
* `vlan` (String) - Vlan name to join in when the server is created.
* `dry_run` - If True, then the service is not provisioned but the information is still returned.

This plugin implements [create.hourly_miniserver()](http://www.memset.com/apidocs/methods_create.html#create.hourly_miniserver) method from the Memset API. Please visit the link for detailed list of accepted values for each "sku" and "os" parameters.  

Vagrant file example:
```
# Path to the private SSH key what Vagrant will use to access the miniserver.
Vagrant.configure("2") do |config|

    config.vm.box = "memset"
	
 	config.vm.provider :memset do |mem|    # e.g.
		mem.api_key  = "apikeystring"                 
    	mem.sku   = "MS0025"
    	mem.os    = "debian_wheezy_64"
		mem.vlan = "caroraa-vlan1"
	end
  end
```
## SSH configuration

Memset Provider  will automatically install a SSH public key onto the new server if "ssh.private_key_path" is provided.  it will be assumed the public key is the same value as "ssh.private_key_path" with ".pub" extension at the end of it.
Config line example:
```
config.ssh.private_key_path = "~/ssh-keys/vagrant"
```
The SSH public key "~/ssh-keys/vagrant.pub" will be installed in the new instance
## Sync folders 

Memset plugins offer minimal supports for sync folders. It requires sudo package installed so distributions where this is not shipped by default will need manual install before running "vagrant provision" command. 
Config line example:
```
config.vm.synced_folder "./provision", "/memset/vagrant-provision"
```
## Contributing

Please create a pull [request](https://github.com/javiee/vagrant-memset/pulls) 
Bugs and support email to javier@memset.com.

