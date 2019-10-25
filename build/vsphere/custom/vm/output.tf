#########################################################
# output
#########################################################
# see resource configuation upon completion, (known after apply)
output "guest_ip_addresses" {
  value = "${vsphere_virtual_machine.vm.guest_ip_addresses}"
}

output "vmware_tools_status" {
  value = "${vsphere_virtual_machine.vm.vmware_tools_status}"
}
