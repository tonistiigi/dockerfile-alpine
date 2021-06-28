variable "ALPINE_REPO" {
  default = "tonistiigi/alpine"
}

target "default" {
  tags = [ALPINE_REPO]
}

target "all" {
  inherits = ["default"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
    "linux/arm/v6",
    "linux/ppc64le",
    "linux/s390x",
    "linux/ppc64le",
    "linux/riscv64"
  ] 
}