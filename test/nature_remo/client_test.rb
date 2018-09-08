require 'test_helper'

class ClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::NatureRemo::VERSION
  end

  def setup
    @client = NatureRemo::Client.new
  end

  def test_with_token
    assert_equal 200, @client.users.status
  end

  def test_get_temperture
    assert_equal 1.class, @client.get_temp.class
    assert_equal 1.class, @client.get_humi.class
  end
end
