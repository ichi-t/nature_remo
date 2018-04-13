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

    desc 'appliances ID SIGNAL', 'Access a appliance'
    def appliances appliance_num = nil, action = nil

      if appliance_num && action
        id = get_appliance_id(appliance_num.to_i)
        signal = get_signal_id(id, action.to_i)
        p client.send_signal(signal)
      elsif appliance_num
        JSON.parse(client.appliances.body)[appliance_num.to_i]["signals"].each_with_index do |signal,i|
          puts "#{i}: #{signal["name"]}"
        end
        return
      end
      
      JSON.parse(client.appliances.body).each_with_index do |appliance, i|
        puts "#{i}: #{appliance["nickname"]}" 
      end
    end

    private
    def client
      client ||= NatureRemo::Client.new
    end

    def get_appliance_id num
      JSON.parse(client.appliances.body)[num]["id"]
    end

    def get_signal_id id, num
      JSON.parse(client.appliances(id).body)[num]["id"]
    end

  end
end
