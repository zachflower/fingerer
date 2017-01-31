require 'octokit'
require 'socket'

require "fingerer/version"
require "fingerer/debug"
require "fingerer/table"
require "fingerer/time"

module Fingerer
  class Server

    def self.start(options = {})
      options[:listen] ||= '0.0.0.0'
      options[:port] ||= 79

      Debug.info("Booting Fingerer")

      server = ::TCPServer.new(options[:listen], options[:port])

      Debug.info("Listening on tcp://#{options[:listen]}:#{options[:port]}");
      Debug.info("Ctrl-C to shutdown server\n");

      loop do
        Thread.start(server.accept) do |client|
          # start timer
          start_time = Time.now
          sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
          username = client.gets.strip

          Debug.info("Started request for \"#{username}\" from #{remote_ip}")

          begin
            user = ::Octokit.user(username)

            client.puts("")

            if user.type == 'User'
              client.puts(Table.header("User"))
            else
              client.puts(Table.header("Organization"))
            end

            client.puts(Table.row(""))
            client.puts(Table.row("Username: #{user.login}", "Full Name: #{user.name}"))
            client.puts(Table.row("Website: #{user.blog}", "Email: #{user.email}")) if user.blog || user.email
            client.puts(Table.row("Location: #{user.location}")) if user.location
            client.puts(Table.row(""))

            if user.type == 'User'
              client.puts(Table.header("Stats"))
              client.puts(Table.row(""))
              client.puts(Table.row("Followers: #{user.followers}", "Following: #{user.following}", "Repositories: #{user.public_repos}"))
              client.puts(Table.row(""))
            end

            if user.bio
              client.puts(Table.header("Biography"))
              client.puts(Table.row(""))

              user.bio.scan(/\S.{0,72}\S(?=\s|$)|\S+/).each do |line|
                client.puts(Table.row(line))
              end

              client.puts(Table.row(""))
            end

            client.puts(Table.line)
            client.puts("")
            client.puts("Member since #{user.created_at.strftime("%c")}")
          rescue Octokit::NotFound
            client.puts("No such user \"#{username}\"")
          rescue => e
            client.puts("Something went wrong")
            Debug.error(e.message)
          end

          client.close

          # end timer
          end_time = Time.now

          Debug.info("Completed request for \"#{username}\" from #{remote_ip} in #{(end_time.to_ms - start_time.to_ms)}ms")
        end
      end
    end
  end
end
