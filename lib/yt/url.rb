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
    # @return [Hash] the information retrieved from the text of the URL
    attr_reader :info

  ### URL info

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

    # @param [String] text the name or URL of a YouTube resource (in any form).
    # @param [Hash] opts dependencies for testing. Defaults are provided.
    def initialize(text, opts={})
      inject_dependencies(opts)
      @text = text.to_s.strip
      @info = parse(text)
    end

    def parse(text)
      parser.new.parse(text)
    end

    def rsrc_id
      @rsrc_id ||= resource_id.new(info).fetch
    end

    def rsrc(options)
      @rsrc ||= resources[kind].call options.merge(id: id)
    end

    def resources
      @resources.dictionary
    end

    def inject_dependencies(opts)
      @parser      = opts.fetch :parser,      Yt::YTUrlParser
      @resource_id = opts.fetch :resource_id, Yt::YTResourceId
      @resources   = opts.fetch :resources,   Yt::Resources
    end
  end
end
