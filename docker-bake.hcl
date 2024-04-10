variable "USERNAME" {
    default = "ashleykza"
}

variable "APP" {
    default = "kohya"
}

variable "RELEASE" {
    default = "2.2.0"
}

variable "CU_VERSION" {
    default = "118"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${USERNAME}/${APP}:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"
        TORCH_VERSION = "2.1.2+cu${CU_VERSION}"
        XFORMERS_VERSION = "0.0.23.post1+cu${CU_VERSION}"
        KOHYA_VERSION = "v23.1.3"
        RUNPODCTL_VERSION = "v1.14.2"
    }
}
