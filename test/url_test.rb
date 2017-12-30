require_relative 'test_helper'
require_relative '../lib/yt/url'

class UrlTest < MiniTest::Test
  def setup
    @channel_id_form = 'www.youtube.com/channel/UC4lU5YG9QDgs0X2jdnt7cdQ'
    @channel_custom_name_form = 'www.youtube.com/c/UC4lU5YG9QDgs0X2jdnt7cdQ'
  end

  def test_kind_returns_the_resource_kind_parsed_from_the_url_text
    url = Yt::URL.new( @channel_id_form )
    assert_equal :channel, url.kind
  end

  def test_id_returns_the_resource_id_parsed_from_the_url_text
    url = Yt::URL.new( @channel_id_form )
    assert_equal 'UC4lU5YG9QDgs0X2jdnt7cdQ', url.id
  end

  def test_id_returns_the_resource_id_fetched_from_the_url
    url = Yt::URL.new( @channel_custom_name_form,
                       resource_id: MockResourceId )
    assert_equal 'UC4lU5YG9QDgs0X2jdnt7cdQ', url.id
  end

  def test_resource_returns_the_resource_associated_with_the_URL
    url = Yt::URL.new( @channel_id_form,
                       resource_id: MockResourceId,
                       resources: MockResources )
    assert_equal 'a channel resource', url.resource.describe
  end

  def test_resource_raises_Yt_NoItemsError_with_kind_unknown
    assert_raises Yt::NoItemsError do
      Yt::URL.new( 'not a resource',
                   resource_id: MockResourceId,
                   resources: MockResources ).resource
    end
  end
end
