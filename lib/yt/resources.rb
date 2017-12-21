module Yt
  class Resources
    # @return [Hash] a dictionary of resource creation lambdas
    def self.dictionary
      r = Hash.new(   -> (_) {raise Yt::NoItemsError} )
      r[:channel]  = -> (options) {Yt::Channel.new options}
      r[:video]    = -> (options) {Yt::Video.new options}
      r[:playlist] = -> (options) {Yt::Playlist.new options}
      r
    end
  end
end
