# frozen_string_literal: true
module Yt
  # Retrieves the YouTube resource id given the format and name of the resource
  # Queries the YouTube API
  class YTResourceId
    # @param [Hash] url_elements a hash of the format and name of the resource
    def initialize(url_elements, yt_link=Yt::YtLink)
      @url_elements = url_elements
      @yt_link = yt_link.new
    end

    # @return [<String, nil>] the ID of the YouTube resource
    # Will raise Yt::NoItemsError if the query response does not provide an ID
    def fetch_id
      response = yt_link.query_for_resource(url_elements)
      extract_id(response)
    end

  private
    attr_reader :url_elements, :yt_link

    def extract_id(response)
      regex = %r{<meta itemprop=\"channelId\" content=\"(?<id>UC[a-zA-Z0-9_-]{22})\">}
      md = response.body.match(regex)
      md ? md[:id] : (raise Yt::NoItemsError)
    end
  end
end
