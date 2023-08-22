resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/18"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                               = "eu-central-1a-public1"
    Tier                               = "public"
    "kubernetes.io/cluster/MoonActive" = "shared"
    "kubernetes.io/role/elb"           = 1
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.64.0/18"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                               = "eu-central-1b-public2"
    Tier                               = "public"
    "kubernetes.io/cluster/MoonActive" = "shared"
    "kubernetes.io/role/elb"           = 1
  }
}


resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "eu-central-1a"
  tags = {
    Name                               = "eu-central-1a-private1"
    Tier                               = "private"
    "kubernetes.io/cluster/MoonActive" = "shared"
    "kubernetes.io/role/internal-elb"  = 1
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.192.0/18"
  availability_zone = "eu-central-1b"
  tags = {
    Name                               = "eu-central-1a-private2"
    Tier                               = "private"
    "kubernetes.io/cluster/MoonActive" = "shared"
    "kubernetes.io/role/internal-elb"  = 1
  }
}