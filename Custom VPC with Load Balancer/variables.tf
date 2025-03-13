variable "CIDR" {
    default = "10.0.0.0/24"
}


variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "ami" {
    type = string
    default = "ami-06fa805f550b430de"
}
