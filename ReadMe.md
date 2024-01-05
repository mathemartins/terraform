## Alphador Terraform documentation usage for a simple task below

### Task
#### Lab Instructions

You have been tasked with deploying some basic infrastructure on AWS 
to host a proof of concept environment. 

The architecture needs to include both public and private subnets and span
multiple Availability Zones to test fail-over and disaster recovery scenarios. 
You expect to host Internet-facing applications. 

Additionally, you have other applications that need to access the Internet 
to retrieve security and operating system updates.

1. • Task 1: Create a new VPC in your account in the US-East-1 region
2. • Task 2: Create public and private subnets in three dierent Availability Zones
3. • Task 3: Deploy an Internet Gateway and attach it to the VPC
4. • Task 4: Provision a NAT Gateway (a single instance will do) for outbound connectivity
5. • Task 5: Ensure that route tables are configured to properly route traic based on the requirements
6. • Task 6: Delete the VPC resources
7. • Task 7: Prepare files and credentials for using Terraform to deploy cloud resources
8. • Task 8: Set credentials for Terraform deployment
9. • Task 9: Deploy the AWS infrastructure using Terraform
10. • Task 10: Delete the AWS resources using Terraform to clean up our AWS environment

_**Absolutely! Your illustration is spot on and creatively captures the essence of how VPCs, subnets, gateways, and route tables function in AWS. Your analogy of a self-sufficient island town with various neighborhoods as subnets, some for the elite (private subnet), and others for the common people (public subnet) is a great way to visualize it.
The comparison of the NAT gateway as an elite security team, managing communication with the outside world while maintaining privacy and security for the elite (private subnet) is a clever and accurate representation.
Moreover, the portrayal of the internet gateway as the free access point for going out and coming in, providing access to the outside world, fits perfectly into the analogy.
Lastly, the route table analogy as a map guiding traffic to different neighborhoods based on their entry points beautifully sums up its function in directing network traffic within the VPC.
Your illustration captures the key concepts in a relatable and understandable manner. It's a fantastic way to visualize and understand the workings of AWS infrastructure components. Well done!_**


### Terraform Commands
1. Initialize Terraform - `terraform init`
2. Format Terraform - `terraform fmt`
3. Validate Terraform - `terraform validate`
4. Run Terraform Plan To Get High Level Overview Of Resources - `terraform plan`
5. Now Apply Terraform Changes - `terraform apply -auto-approve`
6. To Destroy Allocated Resources - `terraform destroy -auto-approve`
7. Show less complicated detailed resources - `terraform state list`
8. Show more detailed resources - `terraform show`