require_relative 'config'
require 'aws-sdk-sqs'

# Queue URL can be stored in configuration yaml file
sqs = Aws::SQS::Client.new(
  access_key_id: config.AWS_ACCESS_KEY_ID,
  secret_access_key: config.AWS_SECRET_ACCESS_KEY,
  region: config.AWS_REGION
)

q_url = sqs.get_queue_url(queue_name: 'soa_queue').queue_url
queue = Aws::SQS::Queue.new(url: q_url, client: sqs)

# SEND several messages from one process or application
def send_message(queue, msg, unique)
  queue.send_message(
    message_body: msg.to_json,
    message_group_id: 'soa_demo',
    message_deduplication_id: 'soa-demo' + unique.hash.to_s
  )
end

5.times { |i| send_message(queue, {code: i}, Time.now) }


# POLL for messages from another process or application
q_url = sqs.get_queue_url(queue_name: 'soa_queue').queue_url

poller = Aws::SQS::QueuePoller.new(q_url, client: sqs)
poller.poll do |msg|
  print "MESSAGE: #{JSON.parse msg.body}, "
end
