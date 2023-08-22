resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  description = "Bastion Host Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_security_group" "front_lb_sg" {
  name        = var.front_lb_sg_name
  description = "Frontend/External Load Balancer Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_security_group" "Webserver_sg" {
  name        = var.Webserver_sg_name
  description = "Webservers Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443, 22]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.front_lb_sg.id]
      
      }
  }

  dynamic "ingress" {
    for_each = [22]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bastion_sg.id]
    }
  }
}

resource "aws_security_group" "backend_lb_sg" {
  name        = var.backend_lb_sg_name
  description = "Backend Load Balancer Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.Webserver_sg.id]
    }
  }
}

resource "aws_security_group" "Appserver_sg" {
  name        = var.Appserver_sg_name
  description = "Appservers Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443, 22]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.backend_lb_sg.id]
      
    }
  }

  dynamic "ingress" {
    for_each = [22]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.bastion_sg.id]
    }
  }
}

resource "aws_security_group" "db_sg" {
  name        = var.database_sg_name
  description = "Database Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [3306]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.Appserver_sg.id, aws_security_group.bastion_sg.id]
    }
  }
}
