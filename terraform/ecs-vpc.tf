/* Create the VPC for this ECS deployment*/

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "${var.name_prefix}-webapp"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name_prefix}-webapp"
    }
}

resource "aws_route_table" "rtable" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.igw}"
    }

    tags {
        Name = "${var.name_prefix}-webapp"
    }
}

resource "aws_main_route_table_association" "a" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.rtable.id}"
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
    domain_name_servers = ["AmazonProvidedDNS"]

    tags {
        Name = "${var.name_prefix}-webapp"
    }
}

resource "aws_vpc_dhcp_options_association" "a" {
    vpc_id = "${aws_vpc.main.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
}

/* For better availability, we will create our VPC in 2 different availability zones */
resource "aws_subnet" "subnet" {
    count = 2
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    availability_zone = "${element(data.aws_availability_zones.available, count.index)}"

    tags {
        Name = "${var.name_prefix}-webapp"
    }
}