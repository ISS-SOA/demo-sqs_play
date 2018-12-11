# frozen_string_literal: true

cd CodePraise
require 'aws-sdk-sqs'

sqs = Aws::SQS::Client.new(
  access_key_id: Api.config.AWS_ACCESS_KEY_ID,
  secret_access_key: Api.config.AWS_SECRET_ACCESS_KEY,
  region: Api.config.AWS_REGION
)

q_url = Api.config.CLONE_QUEUE_URL
queue = Aws::SQS::Queue.new(url: q_url, client: sqs)

msg = Representer::Project.new(Database::ProjectOrm.first).to_json
queue.send_message(message_body: msg)
