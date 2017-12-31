require 'yt/core'
require_relative 'parser'
require_relative 'resource_id'
require_relative 'resources'

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
  ### URL info

    # @param [String] text the name or URL of a YouTube resource (in any form).
    # @param [Hash] opts dependencies for testing. Defaults are provided.
    def initialize(text, opts={})
      inject_dependencies(opts)
      @text = text.to_s.strip
    end

    # @return [Symbol] the kind of YouTube resource matching the URL.
    # Possible values are: +:playlist+, +:video+, +:channel+, and +:unknown:.
    def kind
      info[:kind]
    end

    # @return [<String, nil>] the ID of the YouTube resource matching the URL.
    def id
      info['id'] || rsrc_id
    end

    # @return [<Yt::Channel>] the resource associated with the URL
    def resource(options = {})
      rsrc(options)
    end

  private
    attr_reader :text, :parser, :resource_id

    def info
      parser.new.parse(text)
    end

    def rsrc_id
      @rsrc_id ||= resource_id.new(info).fetch_id
    end

    def rsrc(options)
      rsrc_opts = Marshal.load(Marshal.dump(options))
      resources[kind].call rsrc_opts.merge(id: id)
    end

    def resources
      @resources.dictionary
    end

    def inject_dependencies(opts)
      @parser      = opts.fetch :parser,      Yt::Parser
      @resource_id = opts.fetch :resource_id, Yt::YTResourceId
      @resources   = opts.fetch :resources,   Yt::YTResources
    end
  end
end
