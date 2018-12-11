
# SET the following environment variables first:
#   AWS_ACCESS_KEY_ID       (for auto configuration)
#   AWS_SECRET_ACCESS_KEY   (for auto configuration)
#   AWS_REGION              (for configuration below)

# OR use econfig to set env variables for AWS

require 'json'
require_relative 'config'
require 'aws-sdk-sqs'

sqs = Aws::SQS::Client.new(
  access_key_id: config.AWS_ACCESS_KEY_ID,
  secret_access_key: config.AWS_SECRET_ACCESS_KEY,
  region: config.AWS_REGION
)

sqs.create_queue(
  queue_name: 'soa_queue'
)
