provider "google" {
  credentials = file("./creds.json")
  project     = var.project_id
  region      = var.region
}

# Task 1: Create a new VPC in your account in the specified region
resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# Task 2: Create public and private subnets in specified Availability Zones
resource "google_compute_subnetwork" "public_subnets" {
  count         = length(var.availability_zones)
  name          = "public-subnet-${count.index + 1}"
  ip_cidr_range = var.public_subnets_cidr[count.index]
  region        = var.region
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "private_subnets" {
  count         = length(var.availability_zones)
  name          = "private-subnet-${count.index + 1}"
  ip_cidr_range = var.private_subnets_cidr[count.index]
  region        = var.region
  network       = google_compute_network.vpc.self_link
}

# Task 3: Deploy an Internet Gateway and attach it to the VPC
# Google Cloud doesn't have an Internet Gateway equivalent,
# as it uses default internet access for public subnets without explicit gateways.

# Task 4: Provision a NAT Gateway (a single instance will do) for outbound connectivity
resource "google_compute_router" "nat_router" {
  name    = "my-nat-router"
  network = google_compute_network.vpc.self_link

}

# Get the IP address of the NAT gateway
data "google_compute_router" "nat_gateway_ip" {
  name    = google_compute_router.nat_router.name
  region  = var.region
  project = var.project_id
  network = google_compute_network.vpc.self_link
}

# Task 5: Ensure that route tables are configured to properly route traffic based on the requirements
resource "google_compute_route" "public_route" {
  name       = "public-route"
  network    = google_compute_network.vpc.self_link
  dest_range = "0.0.0.0/0" # CIDR block for public subnets

  # Define a default route for public subnets via the NAT router's IP address
  next_hop_ip = data.google_compute_router.nat_gateway_ip.self_link
}

resource "google_compute_route" "private_route" {
  name       = "private-route"
  network    = google_compute_network.vpc.self_link
  dest_range = "0.0.0.0/0" # CIDR block for private subnets

  # Define a default route for private subnets via the NAT router's IP address
  next_hop_ip = data.google_compute_router.nat_gateway_ip.self_link
}




