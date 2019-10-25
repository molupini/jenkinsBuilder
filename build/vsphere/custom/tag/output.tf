#########################################################
# output
#########################################################
# see resource configuation upon completion, (known after apply)
output "vsphere_tag_category" {
    value = {
        for category in vsphere_tag_category.category:
        category.id => category.id
    }
}