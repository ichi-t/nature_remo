# coding: utf-8
require 'thor'
require 'json'

module NatureRemo
  class Cli < Thor
    desc 'devices', 'find all devices'
    def devices
      puts JSON.parse(client.devices.body)
    end

    desc 'me', 'print nickname'
    def me
      puts JSON.parse(client.users.body)["nickname"]
    end

    desc 'appliances ID SIGNAL', 'Access a appliance'
    def appliances appliance_num = nil, action = nil

      if appliance_num && action
        id = get_appliance_id(appliance_num.to_i)
        signal = get_signal_id(id, action.to_i)
        puts 'sending...'
        client.send_signal(signal)
        puts 'done'
      elsif appliance_num
        if appliances_body[appliance_num.to_i]["type"] == "AC"
          puts "Use 'aircon' command."
        end
        appliances_body[appliance_num.to_i]["signals"].each_with_index do |signal,i|
          puts "#{i}: #{signal["name"]}"
        end
      else
        appliances_body.each_with_index do |appliance, i|
          puts "#{i}: #{appliance["nickname"]}" 
        end
      end
    end

    desc 'aircon', 'Control Air conditioner'
    def aircon mode = nil, temp = nil, volume = nil
      aircon_id = []
      appliances_body.each_with_index do |a, i|
        aircon_id << get_appliance_id(i) if a["type"] == "AC"
      end
      if aircon_id.length == 1
        client.aircon_setting aircon_id.first, temp, mode, volume
        # This method supports only one air conditioner
      end
    end

    desc 'temp', 'Get temperture and humidity'
    def temp
      value = client.events
      puts "Temperture: #{value["te"]["val"]}℃"
      puts "Humidity:   #{value["hu"]["val"]}%"
    end

    private
    def client
      client ||= NatureRemo::Client.new
    end

    def appliances_body
      appliances ||= JSON.parse(client.appliances.body)
    end

    def get_appliance_id num
      appliances_body[num]["id"]
    end

    def get_signal_id id, num
      JSON.parse(client.appliances(id).body)[num]["id"]
    end

  end
end
