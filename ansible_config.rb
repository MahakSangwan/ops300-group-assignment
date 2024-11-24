def anisble_provision(config)
    config.vm.provision "ansible_local" do |ansible|
        ansible.playbook = ("provisioning/playbook.yaml")
        ansible.groups = {
            "private_network_clients" => ["client-[1:2]"],
            "private_network_gateway" => ["client-router"],
            
            
            "company_public_network_nodes" => ["agent-node-[1:2]"],
            "company_public_network_gateway" => ["company-router-public"],
            "company_private_network_nodes" => ["control-node-k8s", "control-node-ansible"],
            "company_private_network_gateway" => ["company-router-private"],
            
            "private_network:children" => ["private_network_clients", "private_network_gateway"],
            "simulated_internet:children" => ["private_network_gateway", "company_public_network_gateway"],
            "company_public_network:children" => ["company_public_network_nodes", "e222222222222", "company_private_network_gateway"],
            "company_private_network:children" => ["company_private_network_nodes", "company_private_network_gateway"],
            "clients:children" => ["private_network_clients", "company_public_network_nodes", "company_private_network_nodes"],
            "gateways:children" => ["private_network_gateway", "company_public_network_gateway", "company_private_network_gateway"]
        }
    end
end