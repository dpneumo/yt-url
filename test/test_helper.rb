require 'minitest/autorun'

require_relative 'interface_tests'
require_relative 'mocks/mock_resource_id'
require_relative 'mocks/mock_resources'
require_relative 'mocks/mock_yt_link'

require 'webmock/minitest'
WebMock.disable_net_connect!(allow_localhost: true)
WEBMOCK_HEADERS = { 'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Ruby' }
