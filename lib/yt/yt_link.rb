module Yt
  class YtLink
    # @return [Net::HTTPResponse] the response from the YouTube API
    def query_for_resource(url_elements)
      parms = "/#{url_elements['format']}#{url_elements['name']}"
      response = http_get(parms)
      if response.is_a? Net::HTTPRedirection
        query response[location]
      else
        response
      end
    end

    private
    def http_get(parms)
      Net::HTTP.start 'www.youtube.com', 443, use_ssl: true do |http|
          http.request Net::HTTP::Get.new parms
      end
    end
  end
end
