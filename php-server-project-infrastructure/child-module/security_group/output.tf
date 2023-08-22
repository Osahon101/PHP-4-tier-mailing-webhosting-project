output "front-lb-sg" {
  value = aws_security_group.front_lb_sg.id
}

output "backend-lb-sg" {
    value = aws_security_group.backend_lb_sg.id
}

output "Appserver-sg" {
    value = aws_security_group.Appserver_sg.id
}

output "bastion_sg" {
     value = aws_security_group.bastion_sg.id 
}

output "Webserver_sg" {
    value = aws_security_group.Webserver_sg.id
  
}

output "db_sg" {
  value = aws_security_group.db_sg.id
}