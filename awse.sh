function read_aws_credential() {
    python - "$1" "$2" <<END
import sys, ConfigParser, os

env = sys.argv[1]
key = sys.argv[2]
config = ConfigParser.ConfigParser()
config.read([os.path.expanduser('~/.aws/credentials')])

if config.has_option(env, key):
    print config.get(env, key)
END
}

function read_aws_config() {
    python - "$1" "$2" <<END
import sys, ConfigParser, os

env = sys.argv[1]
key = sys.argv[2]
config = ConfigParser.ConfigParser()
config.read([os.path.expanduser('~/.aws/config')])

if config.has_option(env, key):
    print config.get(env, key)
END
}

function awse() {
    if [[ $# == 0 ]]; then
        unset AWS_ACCESS_KEY_ID
        unset AWS_SECRET_ACCESS_KEY
        unset AWS_PROFILE
        unset AWS_DEFAULT_REGION
        unset AWS_DEFAULT_OUTPUT
        echo "Clearing AWS env variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_PROFILE, AWS_DEFAULT_REGION and AWS_DEFAULT_OUTPUT"
    else
        local KEY_ID=$(read_aws_credential $1 AWS_ACCESS_KEY_ID)
        local ACCESS_KEY=$(read_aws_credential $1 AWS_SECRET_ACCESS_KEY)
        local REGION=$(read_aws_config $1 region)
        local OUTPUT=$(read_aws_config $1 output)

        if [[ $KEY_ID == "" || $ACCESS_KEY == "" ]]; then
            echo "No AWS profile named $1 found or AWS_ACCESS_KEY_ID and/or AWS_SECRET_ACCESS_KEY not set"
        else
            export AWS_PROFILE=$1
            export AWS_ACCESS_KEY_ID=$KEY_ID
            export AWS_SECRET_ACCESS_KEY=$ACCESS_KEY
            export AWS_DEFAULT_REGION=$REGION
            export AWS_DEFAULT_OUTPUT=$OUTPUT
            echo "Updated AWS credentials succesfully:"
            echo "AWS_PROFILE: $AWS_PROFILE"
            echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
            echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY[0,5]..."
            echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"
            echo "AWS_DEFAULT_OUTPUT: $AWS_DEFAULT_OUTPUT"
        fi
    fi
}
