# frozen_string_literal: true
require_relative 'patterns'
module Yt
  class Parser
    # @param [Patterns] class the class holding the regexps used for parsing the url.
    def initialize(patterns = Patterns)
      @patterns = patterns.new.unfolded
      freeze
    end

    # @param [String] text the URL to be parsed
    # @return [Hash] the information parsed out of the text
    def parse(text)
      patterns.
      map {|kind,regex| regex.match(text) {|m| tag_captures(m,kind)} }.
      compact.
      first
    end

  private
    attr_reader :patterns

    def tag_captures(m,kind)
      m.named_captures.merge(kind: kind)
    end
  end
end
