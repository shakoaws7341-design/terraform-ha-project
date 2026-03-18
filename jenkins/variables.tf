variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "key_name"{
    default = "shako_aws_keys"
} 
variable "db_password" {
    description = "rds_password"
    sensitive = true  
}