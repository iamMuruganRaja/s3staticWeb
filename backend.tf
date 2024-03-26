terraform {
  backend "s3" {
    bucket         = "sachinrohitvirat45"
    key            = "terraform"
    region         = "ap-south-1"
  }
}