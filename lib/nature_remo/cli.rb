require 'thor'
require 'json'

module NatureRemo
  class Cli < Thor
    desc 'devices', 'find all devices'
    def devices
      p JSON.parse(client.devices.body)
    end

    private
    def client
      @client ||= NatureRemo::Client.new
    end
  end
end
