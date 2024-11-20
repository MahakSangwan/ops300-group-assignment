require 'yaml'
require_relative 'ansible_config'

Vagrant.configure("2") do |config|

  global_config = YAML.load_file("global.yaml")["config"];
  vm_configs = YAML.load_file("vms.yaml");
  
  config.vm.boot_timeout = 600
  
  vm_configs.each do |name, vm_config| 
    config.vm.define name do |vmobj|
      
      vmobj.vm.box = vm_config.key?('box') ? vm_config['box'] : global_config['box']      
      vmobj.vm.hostname = name

      vm_config['networks'].each do |network|

        if network['type'] == "internal"
          vmobj.vm.network "private_network", virtualbox__intnet: network['name'], ip: network['ip'], netmask: network['netmask'] ? network['netmask'] : "255.255.255.0"
        elsif network['type'] == "nat"
          vmobj.vm.network "public_network", auto_config: network['auto_config']
        end
      
      end
    
    end
  
  end

  anisble_provision(config)

end