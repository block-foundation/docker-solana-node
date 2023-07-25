# Copyright Starling Associates BV. All rights reserved.

# Variables
# =============================================================================

variable "REGISTRY_ENDPOINT" {
  default = "unknown"
}

variable "REPOSITORY_ENDPOINT" {
  default = "unknown"
}

variable "IMAGE_NAME" {
  default = "unknown"
}

variable "BRANCH" {
  default = "unknown"
}

variable "VERSION" {
  default = "unknown"
}


# Targets
# =============================================================================

target "image" {
  context = "./src/${IMAGE_NAME}/"
  dockerfile = "Dockerfile"
  // target = "runner"
  tags = [
    // "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:${BRANCH}-${VERSION}",
    // "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:${BRANCH}-latest",
    // "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:${BRANCH}-${VERSION}",
    // "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:${BRANCH}-latest",
    "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:${VERSION}",
    "${REGISTRY_ENDPOINT}/${IMAGE_NAME}:latest",
    "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:${VERSION}",
    "${REPOSITORY_ENDPOINT}/${IMAGE_NAME}:latest",
    ]
}


# -----------------------------------------------------------------------------

target "_release" {
  args = {
    BUILDKIT_CONTEXT_KEEP_GIT_DIR = 1
    BUILDX_EXPERIMENTAL = 0
  }
}

target "image-all" {
  inherits = ["image", "_release"]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=registry"]
}


# Groups
# =============================================================================

group "default" {
  targets = [
    "image-all"
  ]
} 
