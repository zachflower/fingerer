require 'socket'
require 'octokit'

server = TCPServer.new('0.0.0.0', 79)

loop do
  Thread.start(server.accept) do |client|
    username = client.gets.strip
    user = Octokit.user username

    client.puts "+----------------------------------------------------------------------------+"
    client.puts "|                                                                            |"
    client.puts sprintf "| Login name: %-21s In real life: %-26s |", user.login, user.name
    client.puts sprintf "| Profile type: %-19s Repositories: %-26d |", user.type, user.public_repos
    client.puts sprintf "| Followers: %-22d Following: %-29d |", user.followers, user.following if user.type == 'User'

    if user.location || user.email || user.blog
      client.puts "|                                                                            |"
      client.puts "+-[ Contact ]----------------------------------------------------------------+"
      client.puts "|                                                                            |"

      client.puts sprintf "| Location: %-64s |", user.location if user.location
      client.puts sprintf "| Email: %-67s |", user.email if user.email
      client.puts sprintf "| Website: %-65s |", user.blog if user.blog
    end

    client.puts "|                                                                            |"

    # word-wrap source: https://www.ruby-forum.com/topic/57805#46993
    if user.bio
      client.puts "+-[ Biography ]--------------------------------------------------------------+"
      client.puts "|                                                                            |"

      user.bio.scan(/\S.{0,72}\S(?=\s|$)|\S+/).each do |line|
        client.puts sprintf "| %-74s |", line
      end

      client.puts "|                                                                            |"
    end

    client.puts "+----------------------------------------------------------------------------+"
    client.puts ""
    client.puts "Member since #{user.created_at.strftime("%c")}"

    client.close
  end
end
