/*
 * Public Subnets
 * --------------
 *
 * 1. We create the default route table to the Internet Gatewa
 * 2. We create a private subnet for each AZ
 * 3. Finally we associate each public subnet to the default route table
 *
 */

# Step 1 : new AWS Route Table
resource "aws_route_table" "public" {
  vpc_id           = "${var.vpc_id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igw_id}"
  }

  tags {
    Name             = "${var.name}-public"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxalide_aws_vpc_subnets"
  }
}

# Step 2 : new AWS Subnet(s)
resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags {
    Name             = "${var.name}-public-${var.azs[count.index]}"
    Environment      = "${var.environment}"
    Tier             = "Public"
    ManagementTool   = "Terraform"
    ManagementModule = "oxalide_aws_vpc_subnets"
  }

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

# Step 3 : AWS Route Table Association
resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

/*
 * Nat Gateways
 * ------------
 *
 * 1. We create a new Elastic IP for each Nat Gateway 
 * 2. We create a Nat Gateway in each public subnet with a Elasti IP allocation
 *
 */

# Step 1 : new AWS Elastic IP
resource "aws_eip" "eip_nat_gw" {
  count = "${length(var.public_subnets)}"

  vpc = true
}

# Step : 2 : new AWS Nat Gateway
resource "aws_nat_gateway" "public" {
  count = "${length(var.public_subnets)}"

  allocation_id = "${element(aws_eip.eip_nat_gw.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
}

/*
 * Private Subnets
 * --------------
 *
 * 1. We create each private subnet
 * 2. We create a route table for each private subnet
 *    Default route to the Nat Gateway inside the public subnet of the AZ.
 * 3. Finally we associate each route table to its private subnet
 *
 */

# Step 1 : new AWS Subnet (private)
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags {
    Name             = "${var.name}-private-${var.azs[count.index]}"
    Environment      = "${var.environment}"
    Tier             = "Private"
    ManagementTool   = "Terraform"
    ManagementModule = "oxalide_aws_vpc_subnets"
  }
}

# Step 2 : new AWS Route Table
resource "aws_route_table" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id           = "${var.vpc_id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.public.*.id, count.index)}"
  }

  tags {
    Name             = "${var.name}-private-${var.azs[count.index]}"
    Environment      = "${var.environment}"
    ManagementTool   = "Terraform"
    ManagementModule = "oxalide_aws_vpc_subnets"
  }
}

# Step 3 : AWS Route Table Association
resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
