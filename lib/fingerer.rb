require "fingerer/version"
require 'octokit'
require 'socket'

module Fingerer
  class Server
    def self.start
      server = TCPServer.new('0.0.0.0', 79)

      loop do
        Thread.start(server.accept) do |client|
          username = client.gets.strip

          if username.empty?
            client.close
          end

          begin
            user = Octokit.user username
          rescue
            client.puts "#{username}: no such user"
            client.close
          end

          client.puts ""

          if user.type == 'User'
            client.puts "+-[ User ]-------------------------------------------------------------------+"
          else
            client.puts "+-[ Organization ]-----------------------------------------------------------+"
          end

          client.puts sprintf "| %-74.74s |", ""
          client.puts sprintf "| %-36.36s %-37.37s |", "Username: #{user.login}", "Full Name: #{user.name}"

          if user.blog || user.email
            client.puts sprintf "| %-36.36s %-37.37s |", "Website: #{user.blog}", "Email: #{user.email}"
          end

          if user.location
            client.puts sprintf "| %-74.74s |", "Location: #{user.location}"
          end

          client.puts sprintf "| %-74.74s |", ""

          if user.type == 'User'
            client.puts "+-[ Stats ]------------------------------------------------------------------+"
            client.puts sprintf "| %-74.74s |", ""
            client.puts sprintf "| %-24s %-24s %-24s |", "Followers: #{user.followers}", "Following: #{user.following}", "Repositories: #{user.public_repos}"
            client.puts sprintf "| %-74.74s |", ""
          end

          if user.bio
            client.puts "+-[ Biography ]--------------------------------------------------------------+"
            client.puts sprintf "| %-74.74s |", ""

            user.bio.scan(/\S.{0,72}\S(?=\s|$)|\S+/).each do |line|
              client.puts sprintf "| %-74.74s |", line
            end

            client.puts sprintf "| %-74.74s |", ""
          end

          client.puts "+----------------------------------------------------------------------------+"
          client.puts ""
          client.puts "Member since #{user.created_at.strftime("%c")}"

          client.close
        end
      end
    end
  end
  # Your code goes here...
end
