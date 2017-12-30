require_relative 'test_helper'

class MockResourceIdTest < MiniTest::Test
  include ResourceIdInterfaceTest

  def setup
    @res_id = @object = MockResourceId.new( 'format' => :channel,
                                            'name'   => 'abcd123' )
  end
end

class MockResourcesTest < MiniTest::Test
  include ResourcesInterfaceTest

  def setup
    @object = MockResources
  end
end

class MockYtLinkTest < MiniTest::Test
  include YtLinkInterfaceTest

  def setup
    @object = MockYtLink.new
  end
end
