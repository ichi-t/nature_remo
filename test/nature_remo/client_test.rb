require 'test_helper'

class ClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::NatureRemo::VERSION
  end

  def test_with_token
    client = NatureRemo::Client.new
    assert_equal '', client.devices
  end
end
