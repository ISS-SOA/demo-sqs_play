
# SET the following environment variables first:
#   AWS_ACCESS_KEY_ID       (for auto configuration)
#   AWS_SECRET_ACCESS_KEY   (for auto configuration)
#   AWS_REGION              (for configuration below)

# OR use econfig to set env variables for AWS

require_relative 'config'
require 'json'
require 'aws-sdk-sqs'

sqs = Aws::SQS::Client.new(access_key_id: config.AWS_ACCESS_KEY_ID,
                           secret_access_key: config.AWS_SECRET_ACCESS_KEY,
                           region: config.AWS_REGION)
q_url = sqs.get_queue_url(queue_name: 'soa_queue.fifo').queue_url
queue = Aws::SQS::Queue.new(q_url)

msg = { code: 'indigo' }
unique = Time.now

queue.send_message(
  message_body: msg.to_json,
  message_group_id: 'soa_demo',
  message_deduplication_id: 'soa-demo' + unique.hash.to_s
)
