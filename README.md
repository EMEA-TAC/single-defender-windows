Single-Defender
The Single-Defender Terraform script is designed to deploy and configure a Google Compute Instance with Ubuntu 18.04 LTS (customizable to meet your specific version requirements), pre-configured with a Defender agent for enhanced security. The script utilizes an API token for secure authentication to download and install the Defender agent from a specified location.

Prerequisites
Before running this script, ensure you have the following:

Terraform: Installed on your machine.
Google Cloud Project Access: Necessary permissions to create resources within a Google Cloud project.
Service Account Key File: For authentication with Google Cloud.

Configuration
Token :This is your authorization token for API access, required for downloading and installing the Defender agent. Ensure this token is securely stored.

Google Cloud Provider
The script is set to deploy resources in the us-central1 region and us-central1-a zone, which you can customize. Replace the project and credentials fields with your Google Cloud project ID and the path to your service account key file, respectively.

Usage
1. Prepare Your Files
Ensure your main.tf Terraform configuration is ready, and you have created a secrets.tfvars file with the API token from your tenant.

2. Initialize Terraform
In the directory containing your Terraform files, run:

terraform init

This command initializes Terraform with your configuration.

3. Plan the Deployment
To see what Terraform will do without making any changes, run:

terraform plan -var-file="secrets.tfvars"

4. Apply the Configuration
To apply your Terraform configuration and create the defined resources, run:

terraform apply -var-file="secrets.tfvars"

5. Verify Installation
After the script has successfully executed, it's essential to verify that the Defender agent is correctly installed and running on your Google Compute Instance. Please note, due to initialization and registration processes, the Defender agent might appear in the Prisma Cloud console approximately 8 minutes after installation. Ensure to check the console after this period to confirm the agent's presence and operational status.

Important Notes
The token variable is marked as sensitive to avoid exposure in logs or console output.
Ensure the secrets.tfvars file is securely stored and not shared or committed to version control systems.
The service account used must have sufficient permissions to create and manage resources in Google Cloud.
The Defender installation script and controller host may need updates based on your Defender agent version or region.
By following these steps and recommendations, you can securely deploy and configure a Google Compute Instance with a Defender agent using Terraform.
