require 'minitest/autorun'
require_relative '../lib/yt/url'
require_relative 'mocks/mock_channel'
require_relative 'mocks/mock_resource_id'
require_relative 'mocks/mock_resources'

class UrlTest < MiniTest::Test
  def setup
    @channel_form = 'www.youtube.com/channel/UC4lU5YG9QDgs0X2jdnt7cdQ'
  end

  def test_kind_returns_channel_when_passed_a_channel_form_url
    url = Yt::URL.new( @channel_form,
                       resource_id: Yt::MockResourceId )
    assert_equal :channel, url.kind
  end

  def test_id_returns_the_resource_id_for_the_resource_associated_with_url
    url = Yt::URL.new( @channel_form,
                       resource_id: Yt::MockResourceId )
    assert_equal 'UC4lU5YG9QDgs0X2jdnt7cdQ', url.id
  end

  def test_resource_returns_the_resource_associated_with_the_URL
    url = Yt::URL.new( @channel_form,
                       resource_id: Yt::MockResourceId,
                       resources: Yt::MockResources )
    assert_equal 'a channel resource', url.resource.describe
  end

  def test_resource_raises_Yt_NoItemsError_with_kind_unknown
    assert_raises Yt::NoItemsError do
      Yt::URL.new( 'not a resource',
                   resource_id: Yt::MockResourceId,
                   resources: Yt::MockResources ).resource
    end
  end
end
