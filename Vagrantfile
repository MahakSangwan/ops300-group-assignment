require 'yaml'

Vagrant.configure("2") do |config|

  global_config = YAML.load_file("global.yaml")["config"];
  vm_configs = YAML.load_file("vms.yaml");

  vm_configs.each do |name, vm_config| 
    config.vm.define name do |vmobj|
      
      vmobj.vm.box = vm_config.key?('box') ? vm_config['box'] : global_config['box']      
      vmobj.vm.hostname = name

      vm_config['networks'].each do |network|

        if network['type'] == "internal"
          vmobj.vm.network network['name'], virtualbox__intnet: "private",ip: network['ip'], auto_config: false
        elsif network['type'] == "nat"
          vmobj.vm.network "public_network", auto_config: network['auto_config']
        end
      
      end
    
    end
  
  end

end