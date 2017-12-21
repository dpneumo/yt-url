# frozen_string_literal: true
require_relative 'patterns'
module Yt
  class YTUrlParser
    def parse(text)
      patterns.
      map {|kind,regex| regex.match(text) {|m| tag_captures(m,kind)} }.
      compact.
      first
    end

    private
    attr_reader :patterns
    def initialize(patterns = Patterns)
      @patterns = patterns.new.unfolded
      freeze
    end

    def tag_captures(m,kind)
      m.named_captures.merge(kind: kind)
    end
  end
end
