# Restaurant Manager Serverless Backend

This repository contains the code for the Restaurant Manager Serverless Backend, which is built using AWS services and deployed using Terraform.

## Getting Started

To use and deploy the Restaurant Manager Serverless Backend, follow the steps below.

### Prerequisites

- An AWS account
- AWS Access Key ID and Secret Access Key with appropriate permissions

### Setting Up Access Keys

To set up your AWS Access Key ID and Secret Access Key, follow these steps:

1. Sign in to the AWS Management Console.
2. Open the IAM console.
3. In the navigation pane, choose "Users".
4. Select your IAM user name.
5. Choose the "Security credentials" tab.
6. Under "Access keys", choose "Create access key".
7. Note down the "Access key ID" and "Secret access key" or download the CSV file containing the credentials.
8. Set those in your local configuration.

### Installing Terraform

To install Terraform, perform the following steps:

1. Download the appropriate Terraform binary for your operating system from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html).
2. Extract the downloaded ZIP file to a directory.
3. Add the Terraform executable to your system's PATH environment variable.

### Initiating and Running Terraform

To deploy the Restaurant Manager Serverless Backend using Terraform, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the repository directory.
3. Open the command line or terminal.
4. Run ```terraform init``` to initialize Terraform and download the necessary providers.
5. Run ```terraform plan``` to preview the resources that will be created.
6. Run ```terraform apply``` to deploy the infrastructure.
7. Confirm the deployment by typing "yes" when prompted.
8. Terraform will provision the resources defined in the configuration.

For more information on using Terraform, please refer to the official Terraform documentation: [https://www.terraform.io/docs/index.html](https://www.terraform.io/docs/index.html).

### Clean up after testing

After you have finished testing or if you no longer need the Restaurant Manager Serverless Backend, it is important to clean up the AWS resources to avoid incurring unnecessary costs. To clean up, follow these steps:

1. Open a terminal or command line.
2. Navigate to the directory where this repository is cloned.
3. Run the following command to destroy the infrastructure provisioned by Terraform:

   ```bash
   terraform destroy

If you encounter any issues or have any questions, please open an issue in this repository.

### Running frontend application

1. To test, navigate into `/admin-portal` directory
2. Set `.env` in `/admin-portal` directory.

```bash
REACT_APP_AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXXX" // aws access key id
REACT_APP_AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXX" // aws secret access key
```

3. Type the following commands `npm install && npm run`.
4. the server will start at localhost:3000.

Happy coding.
