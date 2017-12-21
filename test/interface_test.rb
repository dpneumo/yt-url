require 'minitest/autorun'

module ResourceIdInterfaceTest
  def test_implements_fetch_id
    assert_respond_to(@object, :fetch_id)
  end
end

module ResourcesInterfaceTest
  def test_implements_dictionary
    assert_respond_to(@object, :dictionary)
  end
end
