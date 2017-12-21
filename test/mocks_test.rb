require 'minitest/autorun'
require_relative 'interface_test'
require_relative 'mocks/mock_resource_id'
require_relative 'mocks/mock_resources'

class MockResourceIdTest < MiniTest::Test
  include ResourceIdInterfaceTest

  def setup
    @res_id = @object = Yt::MockResourceId.new('format' => :channel, 'name' => 'abcd123')
  end
end

class MockResourcesTest < MiniTest::Test
  include ResourcesInterfaceTest

  def setup
    @object = Yt::MockResources
  end
end
