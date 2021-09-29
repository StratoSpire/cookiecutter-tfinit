# cookiecutter-tfinit

## Requirements
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) >= 2.2
- [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html) >= 1.7
- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) >= 0.15

## Initializing Control Tower

1. In the console, go to [https://console.aws.amazon.com/controltower](https://console.aws.amazon.com/controltower) and click 'Get Started'
2. Resolve any issues in the pre-checks.
3. Follow the prompts for activating Control Tower.
    - name your audit and log-archive accounts according to the following standard
        - `<NAMESPACE>-audit` (e.g. `stratospire-audit`)
        - `<NAMESPACE>-log-archive` (e.g. `stratospire-log-archive`)
4. You will recieve an email with the subject 'Invitation to join AWS Single Sign-On'. Click 'Accept invitation'.
5. Set a new password.
6. Sign in using your new credentials.
7. Grab your user portal URL from [https://console.aws.amazon.com/singlesignon/home](https://console.aws.amazon.com/singlesignon/home)
8. In your terminal, run `aws configure sso` and follow the prompts. Be sure to select your management account and choose the AWSAdministratorAccess role! You will be forwarded to your browser where you can  click `Allow request` then return to your terminal.

```console
foo@bar:~$ aws configure sso
SSO start URL [None]: https://<YOUR_URL>/start
SSO Region [None]: <YOUR_REGION>
There are 3 AWS accounts available to you.
Using the account ID ************
There are 2 roles available to you.
Using the role name "AWSAdministratorAccess"
CLI default client Region [None]: <YOUR_REGION>
CLI default output format [None]:
CLI profile name [AWSAdministratorAccess-************]:

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile AWSAdministratorAccess-************
```

## Initializing the repository
1. Copy the [.tfinit.yaml.example](.tfinit.yaml.example) file to `.tfinit.yaml` in the root directory of your repository, change the required parameters (`<CURRENT_DIRECTORY_OR_REPO_NAME>`, `<NAMESPACE>`, `<MANAGEMENT_ACCOUNT_ID>`), and make any other changes needed to fit your environment.
```console
foo@bar:~$ curl -L -o .tfinit.yaml \
  https://raw.githubusercontent.com/StratoSpire/cookiecutter-tfinit/main/.tfinit.yaml.example
```

2. Use cookiecutter to generate the neccessary files within your repo:
```console
foo@bar:~$ cookiecutter \
  https://github.com/StratoSpire/cookiecutter-tfinit.git \
  --config-file .tfinit.yaml \
  --no-input \
  -o "$(dirname $(pwd))" \
  -f

# See generated files
foo@bar:~$ tree
.
├── deployments
│   └── aws
│       └── us-east-1
│           └── management
│               └── control_tower_customizations
│                   ├── files
│                   │   └── custom-control-tower-configuration
│                   │       ├── example-configuration
│                   │       │   ├── manifest.yaml
│                   │       │   ├── parameters
│                   │       │   │   ├── create-ssm-parameter-keys-1.json
│                   │       │   │   └── create-ssm-parameter-keys-2.json
│                   │       │   ├── policies
│                   │       │   │   └── preventive-guardrails.json
│                   │       │   └── templates
│                   │       │       ├── create-ssm-parameter-keys-1.template
│                   │       │       └── create-ssm-parameter-keys-2.template
│                   │       ├── manifest.yaml
│                   │       └── templates
│                   │           ├── mission-iam-access.template
│                   │           └── platform-admin-role.template
│                   ├── main.tf
│                   ├── providers.tf
│                   ├── terraform.tf
│                   └── versions.tf
├── helpers
│   ├── bin
│   │   ├── bootstrap-requirements.sh
│   │   └── set-env-vars.sh
│   └── files
│       ├── tfinit-iam.yaml
│       └── tfinit-terraform-backend.yaml
└── modules
    └── control-tower-customizations
        ├── main.tf
        ├── modules
        │   └── directory-checksum
        │       ├── examples
        │       │   └── simple
        │       │       ├── example-directory
        │       │       │   └── test.txt
        │       │       ├── main.tf
        │       │       └── outputs.tf
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── scripts
        │       │   └── checksum.sh
        │       ├── variables.tf
        │       └── versions.tf
        ├── scripts
        │   └── push_customizations.sh
        ├── variables.tf
        └── versions.tf

24 directories, 29 files
```

3. Use the `bootstrap-requirements.sh` script to create the resources Terraform needs (IAM role / S3 bucket / DynamoDB table):
```console
foo@bar:~$ export AWS_PROFILE="<PROFILE_NAME_FROM_SSO>"
foo@bar:~$ helpers/bin/bootstrap-requirements.sh
```

4. Everything is ready to go, and you can now run Terraform to deploy the resources:
```console
foo@bar:~$ export AWS_PROFILE="<PROFILE_NAME_FROM_SSO>"
foo@bar:~$ cd deployments/aws/us-east-1/management/control_tower_customizations
foo@bar:~$ terraform init
foo@bar:~$ terraform plan
foo@bar:~$ terraform apply
```
