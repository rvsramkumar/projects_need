<h3>AWS EC2 ASG with Terraform - IaC </h3>

Here we are creating AWS ec2 instance and deploy the node js code and setting up nginx with high availability using terraform. 
After successful script execution you can access the web service with public DNS name by creating CNAME with ELB public DNS. The ec2 instance configured with Autoscaling group, The ELB will monitor ec2 instance healthcheck if any issue in reaching nginx the ASG(Auto Scaling Group) will bring up new instance. The node js (npm) service watched by superviord so if the node process stopped the superviord service itself automatically start the node js. The cloudwatch enabled to send notification through SNS if the ec2 instance reached more than 80% CPU usage.

<h4>Getting Started</h4>

These instructions will get you to run terraform code to get the Web service which will have the node js backend and nginx front-end using AWS cloud services.

<h4>Prerequisites:</h4>

You must have internet connection and administrator privileges to install the below software

OS : Any Linux (Here i used centos 7.6)<br>
AWSCLI : 1.16 (Installed using pip2.7)<br>
Git : Any version to get this repository from github or you can download zip package<br>
Terraform : v0.11.5 (https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip - https://learn.hashicorp.com/terraform/getting-started/install.html)<br>
  Provisioner : Shell script - used to get node js code and setup supervisord. We can use ansible and other provisioner tools.<br>           
AWS Access and Secret keys -  it must have AmazonEC2FullAccess, CloudWatchFullAccess, AmazonSNSFullAccess<br>

<h4>Execution:</h4>

create one folder, here i created gogoui in /opt in my linux box

Download this repository

cd /opt/gogoui/

git clone https://github.com/gmkmanoj/aws_terraform_asg.git

or 

download https://github.com/gmkmanoj/aws_terraform_asg/archive/master.zip and extract to the folder

cd aws_terraform_asg

Generate SSH keys

terraform_asg]# ssh-keygen -f gogokey

Update AWS secret, access key, ssh public_key and private_key in variable.tf file and also update other details based on your requirement
  Here i used t2.micro tier,Amazon Linux AMI, as-south-1 and default security group, default VPC and subnets.
  Make sure your security group allowed All source traffic to access port 80.

Update server_name in nginx_conf.sh file with you domain url.
  The ELB public DNS url only return default index.html. The node js service configured in virtual host so the correct DNS url only return the response from node js.

Now time to bring up the infra and service using terraform

terraform_asg]# terraform --version            # to Verify the terraform version

terraform_asg]# terraform init                 # Install provider pulgins

terraform_asg]# terraform plan                 # Verify the terraform execution plan and verify no errors

terraform_asg]# terraform apply                # setup to environment and services

At the end of the above command execution we will get ELB public DNS url like 
gogoelb-1364375837.ap-south-1.elb.amazonaws.com 

The SNS service will send subscription email to email-id which is mentioned in variable.tf

Create CNAME with above DNS url or add Host record in DNS with elb dns name IP and your domain www.yourdomain.com and verify the "Hello world" page.

terraform_asg]# terraform show                

You can see now the terraform created AWS EC2, AMI, Launch Template, ASG, Target Group and Application Load balancer

if you want to remove the created AWS resources just run terraform destroy

You can ssh the EC2 instance using your private key
Ex : aws_terraform_asg]# ssh -i gogokey ec2-user@<ec2-instance-publicip>

terraform_asg]# terraform destroy

For new code deployment of node js we need to destroy and apply again

Note:
The SNS subscription created by aws cli command so the terraform destroy not cleaning the subscription list.

Reach me @ gmkmanoj@gmail.com for any questions.
