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
      puts JSON.parse(client.users.body)['nickname']
    end

    desc 'appliances ID SIGNAL', 'Access a appliance'
    def appliances(appliance_num = nil, action = nil)
      if appliance_num && action
        id = get_appliance_id(appliance_num.to_i)
        signal = get_signal_id(id, action.to_i)
        puts 'sending...'
        client.send_signal(signal)
        puts 'done'
      elsif appliance_num
        if appliances_body[appliance_num.to_i]['type'] == 'AC'
          puts "Use 'aircon' command."
        end
        appliances_body[appliance_num.to_i]['signals'].each_with_index do |signal, i|
          puts "#{i}: #{signal['name']}"
        end
      else
        appliances_body.each_with_index do |appliance, i|
          puts "#{i}: #{appliance['nickname']}"
        end
      end
    end

    desc 'aircon TEMP MODE', 'Control Air conditioner'
    def aircon(temp = nil, mode = nil, volume = nil)
      if temp =~ /[a-z]/
        mode = temp
        temp = nil
      end

      aircon_id = []
      appliances_body.each_with_index do |a, i|
        aircon_id << get_appliance_id(i) if a['type'] == 'AC'
      end

      if aircon_id.length == 1
        client.aircon_setting aircon_id.first, temp, mode, volume
      else
        puts 'This method supports only one air conditioner'
      end
    end

    desc 'aircon_off', 'Turn off air conditioner'
    def aircon_off()
      aircon_id = []
      appliances_body.each_with_index do |a, i|
        aircon_id << get_appliance_id(i) if a['type'] == 'AC'
      end

      if aircon_id.length == 1
        client.aircon_off aircon_id.first
      else
        puts 'This method supports only one air conditioner'
      end
    end

    desc 'aircon_on', 'Turn on air conditioner'
    def aircon_on()
      aircon_id = []
      appliances_body.each_with_index do |a, i|
        aircon_id << get_appliance_id(i) if a['type'] == 'AC'
      end

      if aircon_id.length == 1
        client.aircon_on aircon_id.first
      else
        puts 'This method supports only one air conditioner'
      end
    end

    desc 'aircon_change_temperature', 'Change the temperature of the air conditioner'
    def aircon_change_temperature(difference)
      diff = difference.to_i
      return if diff == 0

      aircon_id = []
      appliance = nil
      appliances_body.each_with_index do |a, i|
        appliance = a
        aircon_id << get_appliance_id(i) if a['type'] == 'AC'
      end

      if aircon_id.length == 1
        current_temperature = appliance["settings"]["temp"].to_i
        if current_temperature != 0
          client.aircon_setting aircon_id.first, current_temperature + diff

          puts "Temperature set to #{current_temperature + diff}"
        else
          puts 'Could not retrieve the air conditioner currently set temperature'
        end
      else
        puts 'This method supports only one air conditioner'
      end
    end

    desc 'temp', 'Get temperature and humidity'
    def temp
      value = client.events
      puts "Temperature: #{value['te']['val']}℃"
      puts "Humidity:   #{value['hu']['val']}%"
    end

    desc 'illu', 'Get illumination'
    def illu
      value = client.events
      puts "Illumination: #{value['il']['val']}"
    end

    private

    def client
      @client ||= NatureRemo::Client.new
    end

    def appliances_body
      @appliances ||= JSON.parse(client.appliances.body)
    end

    def get_appliance_id(num)
      appliances_body[num]['id']
    end

    def get_signal_id(id, num)
      JSON.parse(client.appliances(id).body)[num]['id']
    end
  end
end
