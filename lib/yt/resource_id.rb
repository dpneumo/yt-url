# frozen_string_literal: true
module Yt
  # Retrieves the YouTube resource id given the format and name of the resource
  # Queries the YouTube API
  class YTResourceId
    # @return [<String, nil>] the ID of the YouTube resource
    # Will raise Yt::NoItemsError if the query response does not provide an ID
    def fetch_id
      response = query_for_resource
      response = query_redirect(location) if response.is_a?(Net::HTTPRedirection)
      extract_id(response)
    end

  private
    attr_reader :url_elements

    # @param [Hash] url_elements a hash of the format and name of the resource
    def initialize(url_elements)
      @url_elements = url_elements
    end

    def query_for_resource
      url = "/#{url_elements['format']}#{url_elements['name']}"
      Net::HTTP.start 'www.youtube.com', 443, use_ssl: true do |http|
        http.request Net::HTTP::Get.new url
      end
    end

    def query_redirect(location)
      Net::HTTP.start 'www.youtube.com', 443, use_ssl: true do |http|
          http.request Net::HTTP::Get.new location
      end
    end

    def extract_id(response)
      regex = %r{<meta itemprop="channelId" content="(?<id>UC[a-zA-Z0-9_-]{22})">}
      md = response.body.match(regex)
      md ? md[:id] : (raise Yt::NoItemsError)
    end
  end
end
