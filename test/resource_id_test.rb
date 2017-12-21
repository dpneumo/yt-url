require 'minitest/autorun'
require_relative 'interface_test'
require_relative '../lib/yt/resource_id'

class YTResourceIdTest < MiniTest::Test
  include ResourceIdInterfaceTest

  def setup
    @res_id = @object = Yt::YTResourceId.new('format' => :channel, 'name' => 'abcd123')
  end
end
