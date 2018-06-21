# NatureRemo

[![Build Status](https://travis-ci.org/ichi-t/nature_remo.svg?branch=master)](https://travis-ci.org/ichi-t/nature_remo)

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

	Commands:
		natureremo appliances ID SIGNAL  # Access a appliance
		natureremo devices               # find all devices
		natureremo help [COMMAND]        # Describe available commands or one specific command
		natureremo me                    # print nickname

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

	$ natureremo aircon [mode] [temperture] [options]

<!-- ## Development -->

<!-- After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. -->

<!-- To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org). -->

<!-- ## Contributing -->

<!-- Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nature_remo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. -->

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<!-- ## Code of Conduct -->

<!-- Everyone interacting in the NatureRemo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/nature_remo/blob/master/CODE_OF_CONDUCT.md). -->
