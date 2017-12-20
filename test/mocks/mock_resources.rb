module Yt
  class MockResources
    def self.dictionary
      r = Hash.new(   -> (_) {raise Yt::NoItemsError} )
      r[:channel]  = -> (options) {Yt::MockChannel.new options}
      r
    end
  end
end
