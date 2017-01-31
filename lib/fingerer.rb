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
          remote_ip = client.peeraddr[-1]
          username = client.gets.strip

          Debug.info("Started request for \"#{username}\" from #{remote_ip}")

          begin
            user = ::Octokit.user(username)

            client.puts(response(user))
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

    private_class_method def self.response(user)
      response = []

      info = info(user)
      stats = stats(user)
      biography = biography(user)

      response << ""
      response << info unless info.empty?
      response << stats unless stats.empty?
      response << biography unless biography.empty?
      response << ""
      response << "Member since #{user.created_at.strftime("%c")}"

      response.join("\n")
    end

    private_class_method def self.info(user)
      response = []

      if user.type == 'User'
        response << Table.header("User")
      else
        response << Table.header("Organization")
      end

      response << Table.row("")
      response << Table.row("Username: #{user.login}", "Full Name: #{user.name}")
      response << Table.row("Website: #{user.blog}", "Email: #{user.email}") if user.blog || user.email
      response << Table.row("Location: #{user.location}") if user.location
      response << Table.row("")

      response.join("\n")
      response
    end

    private_class_method def self.stats(user)
      response = []

      if user.type == 'User'
        response << Table.header("Stats")
        response << Table.row("")
        response << Table.row("Followers: #{user.followers}", "Following: #{user.following}", "Repositories: #{user.public_repos}")
        response << Table.row("")
      end

      response.join("\n")
    end

    private_class_method def self.biography(user)
      response = []

      if user.bio
        response << Table.header("Biography")
        response << Table.row("")

        user.bio.scan(/\S.{0,72}\S(?=\s|$)|\S+/).each do |line|
          response << Table.row(line)
        end

        response << Table.row("")
      end

      response << Table.line

      response.join("\n")
    end
  end
end
