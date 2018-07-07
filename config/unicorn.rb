APP_PATH = "/home/rajkumar/Rajkumar/Projects/rajuthayaa"

working_directory APP_PATH
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

preload_app true

timeout 30

listen "/home/rajkumar/Rajkumar/Projects/rajuthayaa/shared/sockets/unicorn.rajutaya.sock", :backlog => 64

listen 3000, :tcp_nopush => true

pid  APP_PATH + "/unicorn.pid"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end