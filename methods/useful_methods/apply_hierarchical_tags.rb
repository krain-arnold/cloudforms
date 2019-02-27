#This Method is intended to be used as the Custom Automation in a Control
#Policy. The Policy event should be VM Create Complete, and the Policy
#Profile should be applied at the Infrastructure Provider level.

@DEBUG = false
# This is a custom logging method that assumes the "info" log level
def log(msg, level = :info)
  $evm.log(level, "#{msg}")
end

tag_category = "environment"
tag_failsafe = "orphan"

begin
#Create the VM object
vm = $evm.root['vm']
log("The VM name is #{vm.name}") if @DEBUG  

#Create the failsafe tag if it doesn't already exist
$evm.execute('tag_create', tag_category, :name=> tag_failsafe, :description => tag_failsafe) unless $evm.execute('tag_exists?', tag_category, tag_failsafe)

#Retrieve the relevant tag from the parent cluster  
cluster_tag = vm.ems_cluster.tags(tag_category.to_sym).first
log("The Cluster Tag is #{cluster_tag}") if @DEBUG

#Assign the cluster tag to the VM if the tag exists, otherwise assign the failsafe tag
cluster_tag ? vm.tag_assign("#{tag_category}/#{cluster_tag}") : vm.tag_assign("#{tag_category}/#{tag_failsafe}")
end
