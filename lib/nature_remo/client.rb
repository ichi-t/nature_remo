require 'faraday'
require 'json'

module NatureRemo
  class Client
    # nature-remo api http client

    def initialize token = nil
      @token = token || get_token
      @client = Faraday.new :url => 'https://api.nature.global/1'

    end

    def users
      @client.get do |req|
        req.url '/users/me'
      end
    end

    def devices
      @client.get do |req|
        req.url '/devices'
      end
    end

    def appliances appliance = nil
      @client.get do |req|
        req.url '/appliances' if appliance.nil?
        req.url "/appliances/#{appliance}/signals"
      end

    end


    def get_token
      return ENV['NATURE_TOKEN'] if ENV['NATURE_TOKEN'] == true

      json = JSON(File.read(File.expand_path('~/.nature')))
      json['token']
    end

  end
end
