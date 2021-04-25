# NatureRemo

[![Ruby](https://github.com/ichi-t/nature_remo/actions/workflows/ruby.yml/badge.svg?branch=master)](https://github.com/ichi-t/nature_remo/actions/workflows/ruby.yml)
[![Gem Version](https://badge.fury.io/rb/nature_remo.svg)](https://badge.fury.io/rb/nature_remo)

Nature Remo API client

## Installation


```ruby
gem 'nature_remo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nature_remo
	
## Usage
	
```ruby
require 'nature_remo'

client = NatureRemo::Client.new(<token>)

# show username
client.users

# get temperature
client.get_temp

# show nature_remo device lists
client.devices

# show appliances and signal lists
client.appliances

# send signal
client.send_signal(<signal id>)

# send a signal at intervals
#   [OPTIONAL]
#   interval: How long do you want to wait to send next signal?(millisec)
#   times: How many times do you want to send signals?
client.send_signal(<signal id>, interval: 500, times: 10)
```

## CLI Usage

	Commands:
	natureremo aircon TEMP MODE      # Control Air conditioner
	natureremo appliances ID SIGNAL  # Access a appliance
	natureremo devices               # find all devices
	natureremo help [COMMAND]        # Describe available commands or one specific command
	natureremo me                    # print nickname
	natureremo temp                  # Get temperature and humidity
	natureremo illu                  # Get illumination

### CLI with Docker

	docker run --rm -e NATURE_TOKEN='<nature_token>' taisukeichimura/natureremo --help

### Example

#### Control appliance

Show appliances list

	$ natureremo appliances
	0: スピーカー
	1: シーリングライト
	
Show signal list

	$ natureremo appliances 1
	0: 全光
	1: シーン
	2: 常夜灯
	3: 消灯

Send signal

	$ natureremo appliances 1 0
	
#### Control air conditioner

	$ natureremo aircon [temperature] [mode] [options]

	$ natureremo aircon_off
	$ natureremo aircon_on

	$ natureremo aircon_change_temperature +1
	$ natureremo aircon_change_temperature -1

<!-- ## Development -->

<!-- After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. -->

<!-- To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org). -->

<!-- ## Contributing -->

<!-- Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nature_remo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. -->

## TODO

- [X] GET /1/users/me
- [ ] POST /1/users/me
- [ ] GET /1/devices
- [ ] POST /1/detectappliance
- [X] GET /1/appliances
- [ ] POST /1/appliances
- [ ] POST /1/appliance_orders
- [ ] POST /1/appliances/{appliance}/delete
- [ ] POST /1/appliances/{appliance}
- [X] POST /1/appliances/{appliance}/aircon_settings
- [X] GET /1/appliances/{appliance}/signals
- [ ] POST /1/appliances/{appliance}/signals
- [ ] POST /1/appliances/{appliance}/signal_orders
- [ ] POST /1/signals/{signal}
- [ ] POST /1/signals/{signal}/delete
- [X] POST /1/signals/{signal}/send
- [ ] POST /1/devices/{device}
- [ ] POST /1/devices/{device}/delete
- [ ] POST /1/devices/{device}/temperature_offset
- [ ] POST /1/devices/{device}/humidity_offset


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<!-- ## Code of Conduct -->

<!-- Everyone interacting in the NatureRemo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/nature_remo/blob/master/CODE_OF_CONDUCT.md). -->
