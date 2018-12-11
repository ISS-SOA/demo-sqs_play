# frozen_string_literal: true

# Put AWS credentials in config/secrets.yml

require 'json'
require_relative 'config'
require 'aws-sdk-sqs'

sqs = Aws::SQS::Client.new(
  access_key_id: config.AWS_ACCESS_KEY_ID,
  secret_access_key: config.AWS_SECRET_ACCESS_KEY,
  region: config.AWS_REGION
)

q_url = sqs.get_queue_url(queue_name: 'soa_queue').queue_url
queue = Aws::SQS::Queue.new(url: q_url, client: sqs)

msg = { code: "The time is #{Time.now}" }
queue.send_message(message_body: msg.to_json)
