require 'thor'
require 'json'

module NatureRemo
  class Cli < Thor
    desc 'devices', 'find all devices'
    def devices
      p JSON.parse(client.devices.body)
    end

    desc 'me', 'print nickname'
    def me
      p JSON.parse(client.users.body)["nickname"]
    end

    desc 'appliances', 'get appliance list'
    def appliances
      p JSON.parse(client.appliances.body)
    end

    private
    def client
      @client ||= NatureRemo::Client.new
    end
  end
end
