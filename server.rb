require 'socket'
require 'octokit'

server = TCPServer.new('0.0.0.0', 79)

loop do
  Thread.start(server.accept) do |client|
    user = Octokit.user client.gets.strip

    client.puts "Login: #{user.login}                   Name: #{user.name}"
    client.puts "Directory: /Users/zach               Shell: /bin/bash"
    client.puts "On since Sat Jan 28 08:46 (MST) on ttys001"
    client.puts "#{user.bio}"

    client.close
  end
end
