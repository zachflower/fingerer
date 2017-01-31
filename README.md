# Fingerer

[![Code Climate](https://codeclimate.com/github/zachflower/fingerer/badges/gpa.svg)](https://codeclimate.com/github/zachflower/fingerer) [![Build Status](https://travis-ci.org/zachflower/fingerer.svg?branch=master)](https://travis-ci.org/zachflower/fingerer) [![Beerpay](https://beerpay.io/zachflower/fingerer/badge.svg?style=flat)](https://beerpay.io/zachflower/fingerer)

Fingerer is a [finger](https://en.wikipedia.org/wiki/Finger_protocol) server that returns the GitHub profile associated with the provided username. Quickly lookup GitHub user and organization information using a standard `finger` command.

**Syntax**

```
finger zachflower@fingerer.zacharyflower.com
```

**Response**

```
+-[ User ]-------------------------------------------------------------------+
|                                                                            |
| Username: zachflower                 Full Name: Zachary Flower             |
| Website: http://zacharyflower.com    Email: zach@zacharyflower.com         |
| Location: Boulder, CO                                                      |
|                                                                            |
+-[ Stats ]------------------------------------------------------------------+
|                                                                            |
| Followers: 26            Following: 11            Repositories: 35         |
|                                                                            |
+-[ Biography ]--------------------------------------------------------------+
|                                                                            |
| Professional nerd, avid indoorsman, technical writer, contributor          |
| @fixateio, lead developer @emersonstone                                    |
|                                                                            |
+----------------------------------------------------------------------------+

Member since Sat Jul 16 19:20:34 2011
```

## Background

Via Wikipedia:

> The Name/Finger protocol, written by David Zimmerman, is based on Request for Comments document [RFC 742](https://tools.ietf.org/html/rfc742) (December 1977) as an interface to the **name** and **finger** programs that provide status reports on a particular computer system or a particular person at network sites. The finger program was written in 1971 by [Les Earnest](https://en.wikipedia.org/wiki/Les_Earnest) who created the program to solve the need of users who wanted information on other users of the network. Information on who is logged-in was useful to check the availability of a person to meet. This was probably the earliest form of [presence information](https://en.wikipedia.org/wiki/Presence_information) for remote network users.
>
> Prior to the finger program, the only way to get this information was with a [**who**](https://en.wikipedia.org/wiki/Who_(Unix)) program that showed IDs and terminal line numbers (the server's internal number of the communication line, over which the user's terminal is connected) for logged-in users. Earnest named his program after the idea that people would run their fingers down the who list to find what they were looking for.

## Installation

Add this line to your application's Gemfile:

```
gem 'fingerer'
```

And then execute:

```
bundle install
```

Or install it yourself as:

```
gem install fingerer
```

## Usage

```
Usage: fingerer [options]
    -d, --daemonize                  Run as a background process
    -p, --port PORT                  Port to run on (default: 79)
    -l, --listen IP                  IP to listen on (default: 0.0.0.0)
```

**Note: Fingerer must be run as root, as fingerd is expected to be listening on port 79.**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Fingerer is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
