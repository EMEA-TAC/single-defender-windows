variable "token" {
  description = "Authorization token for API access"
  type        = string
  sensitive   = true
}

provider "google" {
  project     = "emea-tac-cloud-and-compute"
  credentials = file("emea-tac-cloud-and-compute-f84a3722b39d.json")
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "my_instance" {
  name         = "kuba-defender-windows"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "windows-server-2019-dc-v20221214"
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Used for external IP configuration, modify if necessary
  }
  
metadata = {
    windows-startup-script-ps1 = <<-EOF
    $parameters = @{
      Uri = "https://europe-west3.cloud.twistlock.com/eu-2-143570911/api/v1/scripts/defender.ps1"
      Method = "Post"
      Headers = @{
        "authorization" = "Bearer ${var.token}"
      }
      OutFile = "defender.ps1"
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest @parameters
    .\defender.ps1 -type serverWindows -consoleCN europe-west3.cloud.twistlock.com -install -v 
  EOF
}
}
