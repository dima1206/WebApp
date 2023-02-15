This guide explains how to prepare your local machine to use code from this repository.

## Ubuntu/Debian

### Git

Official up-to-date documentation: https://git-scm.com/download/linux

Install Git:

```
sudo apt update
sudo apt install git
```

Verify installation:

```
git --version
```

### Terraform

Official up-to-date documentation: https://developer.hashicorp.com/terraform/downloads?product_intent=terraform

Add Terraform repository and install Terraform:

```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

Verify installation:

```
terraform -v
```

### Ansible

Note: Ansible requires UNIX-like machine.

Official up-to-date documentation: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

#### Python 3 and PIP

Install Python 3 and PIP:

```
sudo apt install python3 python3-pip
```

Verify installation:

```
python3 -V
python3 -m pip -V
```

#### Ansible module

Install Ansible for the current user:

```
python3 -m pip install --user ansible
```

While installing Ansible, you may see the following warning:

```
  WARNING: The scripts ansible, ansible-config, ansible-connection, ansible-console, ansible-doc, ansible-galaxy, ansible-inventory, ansible-playbook, ansible-pull and ansible-vault are installed in '/home/<USER>/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
```

In case you see the warning, try relogin to the shell (some shells are configured to check the directory for existence before adding it to the PATH variable). If you still can't run Ansible after the relogin, add the line below to your profile file for the shell (possible file names: .profile, .bashrc, .bash-profile, .zshrc, .zprofile, etc.).

```
PATH="$HOME/.local/bin:$PATH"
```

Verify installation:

```
ansible --version
```

#### boto3 module

The project uses `boto3` to create dynamic inventory from existing AWS instances. Use the following command to install the module:

```
python3 -m pip install --user boto3
```

TODO: `python3 -m pip install --user PyGithub`

### AWS CLI

#### Create a user for AWS CLI

It's recommended to create a separate user with programmatic access and limited permissions.

Create a policy that gives full access to IAM roles:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "rolesanywhere:*",
            "Resource": "*"
        }
    ]
}
```

Now create a new user that has the following policies attached (either directly or trough a group):

- The policy that you just created
- AmazonS3FullAccess (AWS managed)
- AmazonVPCFullAccess (AWS managed)
- AmazonEC2FullAccess (AWS managed)

Important: Save Access key ID and Secret access key somewhere safe. You'll need it later, and the secret key is shown only once when you're creating it.

#### Install AWS CLI

Official up-to-date documentation: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Download AWC CLI for x86:

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Download AWC CLI for ARM:

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
```

Unarchive and install AWS CLI:

```
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
```

Confirm installation:

```
aws --version
```

#### Configure AWS CLI credentials

Use the following command to create a profile named `setup-jenkins`:

```
aws --profile setup-jenkins configure
```

When asked, enter Access key ID and Secret access key that were given to you when you created the user.

You may omit default region and output format, or configure it for your needs if you're planning to also directly use AWS CLI with this user.

## Other systems

TODO: describe the process for other systems (CentOS / WSL)
