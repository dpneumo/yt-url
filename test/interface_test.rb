require 'minitest/autorun'
require_relative '../lib/yt/url'

module ResourceIdInterfaceTest
  def test_implements_fetch_id
    assert_respond_to(@object, :fetch_id)
  end
end
