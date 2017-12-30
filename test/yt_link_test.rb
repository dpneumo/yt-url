require_relative 'test_helper'
require_relative '../lib/yt/yt_link'

class YtLinkTest < MiniTest::Test
  include YtLinkInterfaceTest

  def setup
    @ytl = @object = Yt::YtLink.new
  end

  def test_query_for_resource_might_return_a_valid_channel_id
    stub_request(:get, "https://www.youtube.com/channelabcd1234").
      with(headers: WEBMOCK_HEADERS).
      to_return(status: 200, body: "UCabcdefghijk-0123456789", headers: {})

    response = @ytl.query_for_resource({ 'format' => :channel,
                                         'name' => 'abcd1234' })
    assert_equal 'UCabcdefghijk-0123456789', response.body
  end

  def test_query_for_resource_might_return_an_invalid_channel_id
    stub_request(:get, "https://www.youtube.com/channelabcd1234").
      with(headers: WEBMOCK_HEADERS).
      to_return(status: 200, body: "abcd1234", headers: {})

    response = @ytl.query_for_resource({ 'format' => :channel,
                                         'name' => 'abcd1234' })
    assert_equal 'abcd1234', response.body
  end
end
