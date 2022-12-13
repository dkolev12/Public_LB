# Public_LB

**About this project**

The project consists of two EC2 instances, Public Load Balancer, one DB instance and a CPU Cloud Watch for the two EC2 instances.
The EC2 instances run Amazon Linux and there is a script installing a web server and a message "Hello World". 
Once the code is deployed there is an Output showing the DNS name of the public LB.
If you try to open the DNS through a web browser using HTTP the message of Hello World plus the private ip address of the EC2 instances will be displayed. Please make sure to use HTTP as HTTPS wont work.

---

## Networking

There is a custom VPC in which there are two subnets in different availability zones. The two EC2 instances are in one subnet, the LB and the RDS are deployed in the two subnets as this a requirement related to multiple availability zones.

---

## SSH

Before deploying the code the only manual step required is to create SSH key pair in AWS and add the name of the SSH file in the Terraform code for the two instances (file functions).

connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./key-pair.pem")
    host 
	
---

## Commands
Terraform plan
Terraform apply
