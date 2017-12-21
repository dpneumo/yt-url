require 'minitest/autorun'
require_relative 'interface_test'
require_relative '../lib/yt/resources'

class ResourcesTest < MiniTest::Test
  include ResourcesInterfaceTest

  def setup
    @object = Yt::Resources
  end
end
