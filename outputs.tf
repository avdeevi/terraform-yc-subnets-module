output private_subnet {
 value =[
   for k,o in yandex_vpc_subnet.subnets:
         {"id" =  o.id, "zone" = o.zone, name = k, "cidr" = o.v4_cidr_blocks }  if length(regexall("private", k)) > 0
   ]
}

output public_subnets {
    value = [
      for k,o in yandex_vpc_subnet.subnets:
         {"id" =  o.id, "zone" = o.zone, name = k, "cidr" = o.v4_cidr_blocks }  if length(regexall("public", k)) > 0
      ]
}

