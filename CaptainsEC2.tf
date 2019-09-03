provider "aws" {
  profile = "ViratKohli"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "captains_s3_bucket" {
  bucket = "captains-s3-bucket"
  acl = "private"
}

resource "aws_instance" "CaptainsEC2_tf" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"

  # Adding dependency on S3 bucket to be created first
  depends_on = [aws_s3_bucket.captains_s3_bucket]

  # Specifying a provisoner (local-exec)
  provisoner "local-exec" {
    command = "echo ${aws_instance.CaptainsEC2_tf.id} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.CaptainsEC2_tf.id
}