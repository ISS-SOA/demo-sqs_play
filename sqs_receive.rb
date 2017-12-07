# SET the following environment variables first:
#   AWS_ACCESS_KEY_ID       (for auto configuration)
#   AWS_SECRET_ACCESS_KEY   (for auto configuration)
#   AWS_REGION              (for configuration below)

# OR use econfig to set env variables for AWS

require_relative 'config'
require 'aws-sdk-sqs'

sqs = Aws::SQS::Client.new(
  access_key_id: config.AWS_ACCESS_KEY_ID,
  secret_access_key: config.AWS_SECRET_ACCESS_KEY,
  region: config.AWS_REGION
)

# Queue URL can be stored in configuration yaml file
q_url = sqs.get_queue_url(queue_name: 'soa_queue.fifo').queue_url
queue = Aws::SQS::Queue.new(q_url)

# Method to quickly retrieve, process and delete a message
def get_message(queue)
  messages = queue.receive_messages
  msg = messages.first

  # PROCESS THE MESSAGE (msg) HERE
  yield JSON.parse(msg.body) if block_given?

  queue.delete_messages(
    entries: [
      {
        id: msg.message_id,
        receipt_handle: msg.receipt_handle
      }
    ]
  )
end

get_message(queue) { |m| puts "Message: #{m}" }
