# frozen_string_literal: true
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

  class Patterns
    def unfolded
      tagged_patterns.flat_map {|patterns| unfold(patterns) }
    end

    private
    def tagged_patterns
      { video:    [ %r{youtube\.com/watch\?v=(?<id>[\w-]{11})},
                    %r{youtu\.be/(?<id>[\w-]{11})},
                    %r{youtube\.com/embed/(?<id>[\w-]{11})},
                    %r{youtube\.com/v/(?<id>[\w-]{11})},
                  ].freeze,

        playlist: [ %r{youtube\.com/playlist/?\?list=(?<id>[\w-]+)},
                  ].freeze,

        channel:  [ %r{youtube\.com/channel/(?<id>UC[\w-]{22})},
                    %r{youtube\.com/(?<format>c/|user/)?(?<name>[\w-]+)},
                  ].freeze,

        unknown:  [ %r{.*} ].freeze
      }.freeze
    end

    def unfold(patterns)
      kind = patterns[0]
      regexps = patterns[1]
      regexps.map {|regex| [kind, regex] }
    end
  end

end
