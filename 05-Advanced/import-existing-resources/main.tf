provider "aws" {
  region = "us-east-1"
  
}

import {
  id = "i-0b350e67597f1dbeb" (Replace with your instance id)

  to = aws_instance.example
}