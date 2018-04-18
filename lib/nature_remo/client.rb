require 'launchy'
require 'faraday'
require 'json'

module NatureRemo
  class Client
    # nature-remo api http client

    def initialize token = nil
      @token = token || get_token
      @client = Faraday.new :url => 'https://api.nature.global'
      @client.headers['Authorization'] = "Bearer #{@token}"
      
    end

    def users
      @client.get do |req|
        req.url '/1/users/me'
      end
    end

    def devices
      @client.get do |req|
        req.url '/1/devices'
      end
    end

    def appliances appliance = nil
      @client.get do |req|
        if appliance.nil?
          req.url '/1/appliances'
        else
          req.url "/1/appliances/#{appliance}/signals"
        end
      end
    end

    def send_signal signal
      @client.post do |req|
        req.url "/1/signals/#{signal}/send"
        req.body = { :name => "#{signal}" }
      end
    end


    def get_token
      return ENV['NATURE_TOKEN'] if ENV['NATURE_TOKEN']

      begin
        json = JSON(File.read(File.expand_path('~/.nature')))
        return json['token']
      rescue => e
        set_token
      end
    end

    def set_token
      Launchy.open 'https://home.nature.global'
      print 'input your token:'
      token = STDIN.gets.to_s.chomp
      raise "Invalid Token" unless token.length == 87
      puts 'your token >> ~/.nature'
      File.write(File.expand_path('~/.nature'), JSON.dump({token: token}))
      return token
    end

  end
end
