require 'thor'

module NatureRemo < Thor
  class Cli
    desc 'devices', 'find all devices'
    def devices
      client.devices
    end

    def client
      @client ||= NatureRemo::Client.new
    end
  end
end
