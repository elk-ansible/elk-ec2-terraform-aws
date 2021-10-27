resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.tf_main.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    },
    {
      description      = "HTTP from Everywhere"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }, {
      description      = "SSH from Everywhere"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_allow_tls"
  }
}

resource "aws_security_group" "elk_es_nodes" {
  name        = "elk_es_nodes"
  description = "Elasticsearch nodes "
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
    {
      description      = "HTTP Port Allowed from everywhere"
      from_port        = 9200
      to_port          = 9200
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
     {
      description      = "Transport Port from the VPC only "
      from_port        = 9300
      to_port          = 9300
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.tf_main.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_elk_es_nodes"
  }
}

resource "aws_security_group" "elk_kibana" {
  name        = "elk_kibana"
  description = "Kibana node"
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
    {
      description      = "Kibana Port"
      from_port        = 5601
      to_port          = 5601
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_elk_kibana"
  }
}


resource "aws_security_group" "elk_logstash" {
  name        = "elk_logstash"
  description = "Logstash"
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
        {
      description      = "Logstash Input Beats"
      from_port        = 5044
      to_port          = 5044
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    },
    {
      description      = "Logstash Monitoring port"
      from_port        = 9600
      to_port          = 9600
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_elk_ent_search"
  }
}

resource "aws_security_group" "elk_ent_search" {
  name        = "elk_ent_search"
  description = "Kibana node"
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
    {
      description      = "Ent Search port"
      from_port        = 3002
      to_port          = 3002
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_elk_ent_search"
  }
}

resource "aws_security_group" "elk_apm_server" {
  name        = "elk_apm_server"
  description = "APM Server"
  vpc_id      = aws_vpc.tf_main.id

  ingress = [
    {
      description      = "Enterprise Search port"
      from_port        = 8200
      to_port          = 8200
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "tf_elk_ent_search"
  }
}