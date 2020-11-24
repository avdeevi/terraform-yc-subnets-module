data "yandex_resourcemanager_folder" "my_folder" {
  name =  var.env
}


resource "yandex_vpc_subnet" "subnets" {
  for_each = var.subnets
  name           = each.key
  v4_cidr_blocks = each.value.cidr
  network_id     = var.network_id
  zone           = each.value.zone
  description    = each.value.description
  folder_id      = data.yandex_resourcemanager_folder.my_folder.id
  route_table_id = each.value.routes


  dynamic "dhcp_options" {
      for_each =  length(var.dns_servers) == 0 ? []: ["0"]
      content {
          domain_name_servers = var.dns_servers
          domain_name =  var.domain_name
      }
  }
}

