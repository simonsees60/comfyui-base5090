variable "TAG" {
  default = "slim"
}

group "default" {
  targets = ["common", "dev"]
}

# Common settings for all targets
target "common" {
  context = "."
  platforms = ["linux/amd64"]
}

# Regular ComfyUI image (CUDA 12.4)
target "regular" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = [
    "simonsees60/comfyui-base5090:${TAG}",
    "simonsees60/comfyui-base5090:latest",
  ]
}

# Dev image for local testing
target "dev" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["simonsees60/comfyui-base5090:dev"]
  output = ["type=docker"]
}

# Dev push targets (for CI pushing dev tags, without overriding latest)
target "devpush" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["simonsees60/comfyui-base5090:dev"]
}

target "devpush5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = ["simonsees60/comfyui-base5090:dev-5090"]
}

# RTX 5090 optimized image (CUDA 12.8 + latest PyTorch build)
target "rtx5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = [
    "simonsees60/comfyui-base5090:${TAG}-5090",
    "simonsees60/comfyui-base5090:latest-5090",
  ]
}
