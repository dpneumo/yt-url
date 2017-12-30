require_relative 'test_helper'
require_relative '../lib/yt/resources'

class ResourcesTest < MiniTest::Test
  include ResourcesInterfaceTest

  def setup
    @rsrc = @object = Yt::YTResources
  end

  def test_dictonary_returns_a_hash
    assert_equal Hash, Yt::YTResources.dictionary.class
  end

  def test_dictionary_default_lambda_raises_error_when_called
    assert_raises Yt::NoItemsError do
      Yt::YTResources.dictionary['invalid_key'].call({})
    end
  end
end
