variable "do_ams2" {
  description = "Digital Ocean Amsterdam Data Center 2"
  default     = "ams2"
}

variable "do_ams3" {
  description = "Digital Ocean Amsterdam Data Center 3"
  default     = "ams3"
}

variable "do_blr1" {
  description = "Digital Ocean Bangalore Data Center 1"
  default     = "blr1"
}

variable "do_fra1" {
  description = "Digital Ocean Frankfurt Data Center 1"
  default     = "fra1"
}

variable "do_lon1" {
  description = "Digital Ocean London Data Center 1"
  default     = "lon1"
}

variable "do_nyc1" {
  description = "Digital Ocean New York Data Center 1"
  default     = "nyc1"
}

variable "do_nyc2" {
  description = "Digital Ocean New York Data Center 2"
  default     = "nyc2"
}

variable "do_nyc3" {
  description = "Digital Ocean New York Data Center 3"
  default     = "nyc3"
}

variable "do_sfo1" {
  description = "Digital Ocean San Francisco Data Center 1"
  default     = "sfo1"
}

variable "do_sgp1" {
  description = "Digital Ocean Singapore Data Center 1"
  default     = "sgp1"
}

variable "do_tor1" {
  description = "Digital Ocean Toronto Datacenter 1"
  default     = "tor1"
}

# Default Os

variable "ubuntu" {
  description = "Default LTS"
  default     = "ubuntu-16-04-x64"
}

variable "centos" {
  description = "Default Centos"
  default     = "centos-72-x64"
}

variable "coreos" {
  description = "Defaut Coreos"
  default     = "coreos-899.17.0"
}


# Default sizes

variable "do_size_5" {
  description = "s-1vcpu-1gb	1	1 GB	25 GB	1 TB	$5"
  default     = "s-1vcpu-1gb"
}

variable "do_size_10" {
  description = "s-1vcpu-2gb	1	2 GB	50 GB	2 TB	$10"
  default     = "s-1vcpu-2gb"
}

variable "do_size_15" {
  description = "Standard	s-2vcpu-2gb	2	2 GB	30 GB	3 TB	$15"
  default     = "s-2vcpu-2gb"
}

variable "do_size_15_3G" {
  description = "Standard	s-1vcpu-3gb	1	3 GB	60 GB	3 TB	$15"
  default     = "s-1vcpu-3gb"
}



//Standard	s-2vcpu-2gb	2	2 GB	60 GB	3 TB	$15
//Standard	s-3vcpu-1gb	3	1 GB	60 GB	3 TB	$15
//Standard	s-2vcpu-4gb	2	4 GB	80 GB	4 TB	$20
//Standard	s-4vcpu-8gb	4	8 GB	160 GB	5 TB	$40
//Standard	s-6vcpu-16gb	6	16 GB	320 GB	6 TB	$80
//Standard	s-8vcpu-32gb	8	32 GB	640 GB	7 TB	$160
//Standard	s-12vcpu-48gb	12	48 GB	960 GB	8 TB	$240
//Standard	s-16vcpu-64gb	16	64 GB	1,280 GB	9 TB	$320
//Standard	s-20vcpu-96gb	20	96 GB	1,920 GB	10 TB	$480
//Standard	s-24vcpu-128gb	24	128 GB	2,560 GB	11 TB	$640
//Standard	s-32vcpu-192gb	32	192 GB	3,840 GB	12 TB	$960