require_relative 'test_helper'
require_relative '../lib/yt/patterns'

class PatternsTest < MiniTest::Test
  def setup
    @ptrn = Yt::Patterns.new
  end

  def test_unfolded_returns_an_array_of_2_element_arrays
    assert_equal 2, @ptrn.unfolded.first.size
    assert_equal Symbol, @ptrn.unfolded.first.first.class
    assert_equal Regexp, @ptrn.unfolded.first.last.class
  end
end
