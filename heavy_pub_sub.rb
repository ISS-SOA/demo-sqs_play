require 'aws-sdk'
appstore_sqs = Aws::SQS::Client.new
q_url = appstore_sqs.get_queue_url(queue_name: 'AppStoreQueue').queue_url


# FILLING UP THE QUEUE
reps = (1..3)
combos = (1..144)

reps.each do |r|
  combos.each do |c|
    msg = "#{r}:#{c}"
    print "#{msg}, "
    appstore_sqs.send_message(queue_url: q_url, message_body: msg)
  end
end


# GETTING SETS

# get ticket
msg = appstore_sqs.receive_message(queue_url: q_url)
set = msg.messages.first.body

# delete ticket
del = appstore_sqs.receive_message(queue_url: q_url)


# FULL POLLING
poller = Aws::SQS::QueuePoller.new(q_url)
poller.poll do |msg|
  # ...
  print "#{msg.body}, "
end
