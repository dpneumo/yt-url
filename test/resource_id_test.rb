require_relative 'test_helper'
require_relative '../lib/yt/resource_id'

class YTResourceIdTest < MiniTest::Test
  include ResourceIdInterfaceTest

  def setup
    @object = Yt::YTResourceId.new( { 'format' => :channel,
                                      'name' => 'abcd123' },
                                    MockYtLink )
  end

  def test_fetch_returns_Yt_NoItemsError_when_response_body_channelId_not_valid
    invalid_rsrc_id = @object
    assert_raises Yt::NoItemsError do
      invalid_rsrc_id.fetch_id
    end
  end

  def test_fetch_returns_valid_channelId
    valid_rsrc_id = Yt::YTResourceId.new( { 'format' => :channel,
                                            'name' => 'UCabcdefghijk-0123456789' },
                                          MockYtLink )
    assert_equal "UCabcdefghijk-0123456789", valid_rsrc_id.fetch_id
  end
end
