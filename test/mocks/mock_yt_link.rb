class MockYtLink
  def query_for_resource(url_elements)
    name = url_elements['name']
    if name=='abcd123'
      MockResponse.new( body: name )
    elsif name=='UCabcdefghijk-0123456789'
      MockResponse.new( body: %Q[<meta itemprop="channelId" content="#{name}">] )
    else
      MockResponse.new( body: 'Fail!' )
    end
  end
end

class MockResponse
  attr_reader :body
  def initialize(body: '')
    @body = body
  end
end
