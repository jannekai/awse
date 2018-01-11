# awse
Bash + Python script to update AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_PROFILE env variables using data in ~/.aws/credentials file.

## Setup

Copy the awse.sh to your local machine and source it from your .bashrc and/or .zshrc file.
Or just copy the contents of awse.sh to your .bashrc and/or .zshrc file directly.

## Usage

Suppose you have and ~/.aws/credentials file with the following content:

[dev]
aws_access_key_id = AKIAI123......
aws_secret_access_key = abc...........

[prod]
aws_access_key_id = AKIAI999......
aws_secret_access_key = xyz...........

To switch between dev and prod access keys run the following commands:

```
awse dev
awse prod
```

To clear env variables, simply run _awse_ command without any parameters.
