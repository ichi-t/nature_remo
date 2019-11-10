require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = NatureRemo::Client.new
    WebMock.stub_request(:any, "https://api.nature.global/1/users/me").
      to_return(status: 200)
    WebMock.stub_request(:get, "https://api.nature.global/1/devices").
      to_return(
        status: 200,
        body: "[{\"newest_events\":{\"hu\":{\"val\":50,\"created_at\":\"dummy\"},\"il\":{\"val\":57.2,\"created_at\":\"dummy\"},\"te\":{\"val\":21.2,\"created_at\":\"dummy\"}}}]"
      )
  end

  def test_with_token
    assert_equal 200, @client.users.status
  end

  def test_get_temperature
    assert_equal Float, @client.get_temp.class
  end

  def test_get_humidity
    assert_equal Float, @client.get_humi.class
  end

  def test_get_illumination
    assert_equal Float, @client.get_illu.class
  end
end
