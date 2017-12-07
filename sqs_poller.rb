require_relative 'config'
require 'aws-sdk-sqs'

# SEND several messages from one process or application
queue = Aws::SQS::Queue.new(q_url)
def send_message(queue, msg, unique)
  queue.send_message(
    message_body: msg.to_json,
    message_group_id: 'soa_demo',
    message_deduplication_id: 'soa-demo' + unique.hash.to_s
  )
end

5.times { |i| send_message(queue, {code: i}, Time.now) }


# POLL for messages from another process or application
q_url = sqs.get_queue_url(queue_name: 'soa_queue.fifo').queue_url

poller = Aws::SQS::QueuePoller.new(q_url)
poller.poll do |msg|
  # ...
  print "#{msg.body}, "
end
