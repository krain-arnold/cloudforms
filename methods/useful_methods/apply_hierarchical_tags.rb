@DEBUG = false
# This is a custom logging method that assumes the "info" log level
def log(msg, level = :info)
  $evm.log(level, "#{msg}")
end

begin
#Create the VM object
vm = $evm.root['vm']
log("The VM name is #{vm.name}") if @DEBUG  

#Create the Orphan Environment Tag if it doesn't already exist
$evm.execute('tag_create', 'environment', :name=> 'orphan', :description => 'orphan') unless $evm.execute('tag_exists?', 'environment', 'orphan')

#Retrieve the environment tag from the parent cluster  
environment_tag = vm.ems_cluster.tags(:environment).first
log("The Cluster Environment is #{environment_tag}") if @DEBUG

#Assign the Cluster Environment to the VM if the tag exists, otherwise assign the Orphan tag
environment_tag ? vm.tag_assign("environment/#{environment_tag}") : vm.tag_assign("environment/orphan")

end

