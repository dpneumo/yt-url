# frozen_string_literal: true
class MockResourceId
  attr_reader :url_elements
  def initialize(url_elements)
    @url_elements = url_elements
  end

  def fetch_id
    case url_elements["name"]
    when "UC4lU5YG9QDgs0X2jdnt7cdQ"
      "UC4lU5YG9QDgs0X2jdnt7cdQ"
    else
      raise Yt::NoItemsError
    end
  end
end
