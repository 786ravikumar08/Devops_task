customer                        = "Ravi"
environment                     = "dev"
aws_region                      = "ap-south-1"
white_bastion_ips               = "157.34.110.173/32"
keypair                         = "cc-ravi"

# Elasticsearch Blue
elasticsearch_blue_asg_min      = "1"
elasticsearch_blue_asg_max      = "1"
elasticsearch_blue_asg_desired  = "1"

# Elasticsearch Green
elasticsearch_green_asg_min     = "0"
elasticsearch_green_asg_max     = "0"
elasticsearch_green_asg_desired = "0"


