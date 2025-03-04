# Create an AWS Key Pair to allow SSH access.
resource "aws_key_pair" "keypair" {
# Defining an AWS resource
  key_name   = var.key_name
  public_key = file("C:/Users/Sowmya/.ssh/id_rsa.pub") # Uses an existing public key
}


# Create a bastion host (Jump Server) in a public subnet
resource "aws_instance" "bastion" {
# Defining an AWS resource
  ami                         = "ami-05b10e08d247fb927" # Amazon Linux AMI ID
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.keypair.key_name
  subnet_id                   = var.bastion_subnet # Place in the second public subnet
  associate_public_ip_address = true                         # Assign a public IP
  security_groups             = [var.bastion_sg]
}


# Define a launch template for auto scaling
resource "aws_launch_template" "launch_template" {
# Defining an AWS resource
  name_prefix            = "app-launch-template"
  image_id               = "ami-05b10e08d247fb927" # Update with a valid AMI
  instance_type          = "t2.micro"
  user_data              = filebase64("user-data.sh") # Script to configure the instance
# Fetching existing data from AWS
  vpc_security_group_ids = [var.instance_sg]
  
  lifecycle {
# Managing resource lifecycle rules
    create_before_destroy = true # Ensures the new instance is created before destroying the old one
  }
}

# Auto Scaling Group for the application instances
resource "aws_autoscaling_group" "app_asg" {
# Defining an AWS resource
  vpc_zone_identifier = var.private_app_subnets # Deploy in private subnets
  desired_capacity    = 2
  min_size            = 1
  max_size            = 2
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}
