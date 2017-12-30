require_relative 'mock_channel'
class MockResources
  def self.dictionary
    r = Hash.new(   -> (_) {raise Yt::NoItemsError} )
    r[:channel]  = -> (options) {MockChannel.new options}
    r
  end
end
