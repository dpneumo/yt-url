require 'yt/core'
require_relative 'parser'
require_relative 'resource_id'

# An object-oriented Ruby client for YouTube.
# @see http://www.rubydoc.info/gems/yt/
module Yt
  # Provides methods to identify YouTube resources from names or URLs.
  # @see https://developers.google.com/youtube/v3/docs
  # @example Identify a YouTube video from its short URL:
  #   url = Yt::URL.new 'youtu.be/kawaiiguy'
  #   url.id # => 'UC4lU5YG9QDgs0X2jdnt7cdQ'
  #   url.resource # => #<Yt::Channel @id=UC4lU5YG9QDgs0X2jdnt7cdQ>
  class URL
    # @param [String] text the name or URL of a YouTube resource (in any form).
    attr_reader :text
    def initialize(text, opts={})
      @text = text.to_s.strip
      set_internal_vars(opts)
    end

  ### URL info

    # @return [Symbol] the kind of YouTube resource matching the URL.
    # Possible values are: +:playlist+, +:video+, +:channel+, and +:unknown:.
    def kind
      match[:kind]
    end

    # @return [<String, nil>] the ID of the YouTube resource matching the URL.
    def id
      match['id'] ||= rsrc_id.new(match).fetch
    end

    # @return [<Yt::Channel>] the resource associated with the URL
    def resource(options = {})
      @resource ||= resources[kind].call options.merge(id: id)
    end

  private
    attr_reader :parser, :rsrc_id, :channel, :video, :playlist
    def match
      @match ||= parser.new.parse(text)
    end

    def resources
      r = Hash.new(  -> (_) {raise Yt::NoItemsError} )
      r[:channel]  = -> (options) {channel.new options}
      r[:video]    = -> (options) {video.new options}
      r[:playlist] = -> (options) {playlist.new options}
      r
    end

    def set_internal_vars(opts)
      @parser = opts.fetch :parser, Yt::YTUrlParser
      @rsrc_id = opts.fetch :rsrc_id, Yt::YTResourceId
      @channel = opts.fetch :channel, Yt::Channel
      @video = opts.fetch :video, Yt::Video
      @playlist = opts.fetch :playlist, Yt::Playlist
    end
  end
end
