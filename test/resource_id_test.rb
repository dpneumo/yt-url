require 'minitest/autorun'
require_relative 'interface_test'
require_relative '../lib/yt/resource_id'

class YTResourceIdTest < MiniTest::Test
  include ResourceIdInterfaceTest

  def setup
    @rsrc_id = @object = Yt::YTResourceId.new('format' => :channel, 'name' => 'abcd123')
  end

  def test_resource_id_requires_an_internet_connection_to_the_youtube_api
    assert_raises OpenSSL::SSL::SSLError do
      @rsrc_id.fetch_id
    end
  end
end
