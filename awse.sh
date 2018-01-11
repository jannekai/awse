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

function awse() {
    if [[ $# == 0 ]]; then
        unset AWS_ACCESS_KEY_ID
        unset AWS_SECRET_ACCESS_KEY
        unset AWS_PROFILE
        echo "Clearing AWS env variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_ENV"
        export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_ENV
    else
        local KEY_ID=$(read_aws_credential $1 AWS_ACCESS_KEY_ID)
        local ACCESS_KEY=$(read_aws_credential $1 AWS_SECRET_ACCESS_KEY)

        if [[ $KEY_ID == "" || $ACCESS_KEY == "" ]]; then
            echo "No AWS profile named $1 found or AWS_ACCESS_KEY_ID and/or AWS_SECRET_ACCESS_KEY not set"
        else
            AWS_ACCESS_KEY_ID=$KEY_ID
            AWS_SECRET_ACCESS_KEY=$ACCESS_KEY
            AWS_PROFILE=$1
            echo "Updated AWS credentials succesfully:"
            echo "AWS_PROFILE: $AWS_PROFILE"
            echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
            echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY[0,5]..."
            export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_PROFILE
        fi
    fi
}
