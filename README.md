# Really Simple Tutorial for AWS SQS in Ruby

### A. Setting up this tutorial
The code in this repo will help you interact with AWS SQS for the first time.

1. Clone this repo onto your local machine
2. Run `bundle install` in your local clone of this repo
3. Confirm that all the gems in Gemfile have installed successfully

### B. Setting up SQS:
1. Make sure your IAM identity on Amazon AWS Console gives you 'full access' to the SQS service
2. Create a 'Tutorial' queue on SQS (from your Amazon console)

### C. Sending a message to SQS:
1. open up `sqs_send.rb` in an editor
2. open a terminal; export your AWS credentials as environment variables; run your Ruby REPL (irb/pry) in this terminal
3. copy and paste the lines, one-by-one, from `sqs_send.rb` to your REPL
4. confirm on the SQS website (Amazon console) that your message is in the queue

### D. Reading a single message from SQS
1. once you have a message queued in SQS, open `sqs_pull.rb` in an editor
2. open a second terminal window; export your AWS credentials as environment variables; run your Ruby REPL (irb/pry) in this terminal
2. copy and paste the lines, one-by-one, from `sqs_send.rb` to your REPL; only use the 'First way' instructions to read the message for now
3. after deleting the message, confirm on the SQS website that the message is gone.

### E. Polling SQS Continuously
1. you should by now have two terminal windows open that are each running a Ruby REPL
2. in one of your REPLs, copy and paste the block of code in `sqs_pull.rb` titled as the 'Second way' to read messages -- this block of code will keep printing messages in the queue until you hit Ctrl-C
3. in your second REPL, use the code from `sqs_send.rb` to send multiple messages -- you should see the messages printing out in your first REPL
