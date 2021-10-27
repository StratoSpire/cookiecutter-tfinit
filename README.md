# cookiecutter-tfinit

## What this template creates
- CloudFormation stacks in the ControlTower Management account
  - IAM configuration for use in CI
    - group
    - user
    - access key / secret
  - Terraform State Backend
    - S3 Bucket
    - DynamoDB Table
- Docker Images for use in GitHub Actions
- GitHub Actions Configuration
  - secrets
  - workflows / pipelines
    - primary branch push
    - pull request
- [ControlTower Customizations Implementation](https://aws.amazon.com/solutions/implementations/customizations-for-aws-control-tower/)

## Requirements
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) >= 2.2
- [cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html) >= 1.7
- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) >= 0.15

## Initializing Control Tower

1. In the console, go to [https://console.aws.amazon.com/controltower](https://console.aws.amazon.com/controltower) and click 'Set up landing zone'
2. Resolve any issues found in the pre-flight checks.
3. Follow the prompts for activating Control Tower.
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
1. Copy the [.tfinit.yaml.example](.tfinit.yaml.example) file to `.tfinit.yaml` in the root directory of your repository, change the required parameters (`<NAMESPACE>`, `<MANAGEMENT_ACCOUNT_ID>`, `<GITHUB_PROJECT_OWNER>`, `<GITHUB_PROJECT_NAME>`), and make any other changes needed to fit your environment.
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
│   ├── aws
│   │   └── us-east-1
│   │       └── management
│   │           ├── control_tower_customizations
│   │           │   ├── files
│   │           │   │   └── custom-control-tower-configuration
│   │           │   │       ├── example-configuration
│   │           │   │       │   ├── manifest.yaml
│   │           │   │       │   ├── parameters
│   │           │   │       │   │   ├── create-ssm-parameter-keys-1.json
│   │           │   │       │   │   └── create-ssm-parameter-keys-2.json
│   │           │   │       │   ├── policies
│   │           │   │       │   │   └── preventive-guardrails.json
│   │           │   │       │   └── templates
│   │           │   │       │       ├── create-ssm-parameter-keys-1.template
│   │           │   │       │       └── create-ssm-parameter-keys-2.template
│   │           │   │       ├── manifest.yaml
│   │           │   │       └── templates
│   │           │   │           ├── mission-iam-access.template
│   │           │   │           └── platform-admin-role.template
│   │           │   ├── main.tf
│   │           │   ├── providers.tf
│   │           │   ├── terraform.tf
│   │           │   └── versions.tf
│   │           └── ecr_repositories
│   │               ├── main.tf
│   │               ├── providers.tf
│   │               ├── terraform.tf
│   │               └── versions.tf
│   └── github
│       └── stratospire
│           └── test_cookiecutter
│               └── github_secrets
│                   ├── main.tf
│                   ├── providers.tf
│                   ├── terraform.tf
│                   ├── variables.tf
│                   └── versions.tf
├── docker
│   ├── aws-cli
│   │   └── 2.1.9
│   │       ├── Dockerfile
│   │       └── entrypoint.sh
│   ├── buildpack-deps
│   │   ├── curl
│   │   │   └── focal
│   │   │       └── Dockerfile
│   │   ├── focal
│   │   │   └── Dockerfile
│   │   └── scm
│   │       └── focal
│   │           └── Dockerfile
│   ├── terraform
│   │   └── 1.0.8
│   │       ├── Dockerfile
│   │       └── entrypoint.sh
│   └── ubuntu
│       └── focal
│           ├── Dockerfile
│           └── uidgidwrap
├── helpers
│   ├── bin
│   │   ├── bootstrap-requirements.sh
│   │   └── set-env-vars.sh
│   └── files
│       ├── tfinit-iam.yaml
│       └── tfinit-terraform-backend.yaml
└── modules
    ├── control-tower-customizations
    │   ├── main.tf
    │   ├── scripts
    │   │   └── push_customizations.sh
    │   ├── variables.tf
    │   └── versions.tf
    └── directory-checksum
        ├── examples
        │   └── simple
        │       ├── example-directory
        │       │   └── test.txt
        │       ├── main.tf
        │       └── outputs.tf
        ├── main.tf
        ├── outputs.tf
        ├── scripts
        │   └── checksum.sh
        ├── variables.tf
        └── versions.tf

41 directories, 47 files
```

3. Use the `bootstrap-requirements.sh` script to create the resources Terraform needs (IAM role / S3 bucket / DynamoDB table / GitHub Actions secrets):
```console
foo@bar:~$ export AWS_PROFILE="<PROFILE_NAME_FROM_SSO>"
foo@bar:~$ export GITHUB_TOKEN="<YOUR_GITHUB_TOKEN>"
foo@bar:~$ ./helpers/bin/bootstrap-requirements.sh
```

4. Everything is ready to go! You can now commit your code for the pipeline to pick up:
```console
foo@bar:~$ git add -A
foo@bar:~$ git commit -m "initial commit of tfinit"
foo@bar:~$ git push origin main
```
