require_relative 'test_helper'
require_relative '../lib/yt/url'

class IntegrationTest < MiniTest::Test
  def setup
  end

  # Kind
  def test_yturl_kind_returns_the_YT_resource_kind_given_an_id_form_url
    yturl = Yt::URL.new('https://www.youtube.com/channel/UC4lU5YG9QDgs0X2jdnt7cdQ')
    assert_equal :channel, yturl.kind
  end

  # Resource Id
  #    Id form url
  def test_yturl_id_returns_the_YT_resouce_id_given_an_id_form_url
    yturl = Yt::URL.new('https://www.youtube.com/channel/UC4lU5YG9QDgs0X2jdnt7cdQ')
    assert_equal 'UC4lU5YG9QDgs0X2jdnt7cdQ', yturl.id
  end
  #    Name form url
  def test_yturl_id_returns_the_YT_resouce_id_given_a_name_form_url_c_resource_name
    stub_request(:get, "https://www.youtube.com/nbcsports").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    %Q[<meta itemprop="channelId" content="UCqZQlzSHbVJrwrn5XvzrzcA">],
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/nbcsports')
    assert_equal 'UCqZQlzSHbVJrwrn5XvzrzcA', yturl.id
  end

  def test_yturl_id_returns_the_YT_resouce_id_given_a_name_form_url_c_user_name
    stub_request(:get, "https://www.youtube.com/george123").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    %Q[<meta itemprop="channelId" content="UCqZQlzSHbVJrwrn5XvzrzcA">],
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/george123')
    assert_equal 'UCqZQlzSHbVJrwrn5XvzrzcA', yturl.id
  end

  def test_yturl_id_raises_YT_NoItemsError_given_a_name_form_url_c_unrecognized_name
    stub_request(:get, "https://www.youtube.com/unknown-name").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    "Name is unrecognized",
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/unknown-name')
    assert_raises Yt::NoItemsError do
      yturl.id
    end
  end
  #    Custom form url
  def test_yturl_id_returns_the_YT_resouce_id_given_a_custom_form_url_c_resource_name
    stub_request(:get, "https://www.youtube.com/c/nbcsports").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    %Q[<meta itemprop="channelId" content="UCqZQlzSHbVJrwrn5XvzrzcA">],
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/c/nbcsports')
    assert_equal 'UCqZQlzSHbVJrwrn5XvzrzcA', yturl.id
  end

  def test_yturl_id_raises_YT_NoItemsError_given_a_custom_form_url_c_unrecognized_name
    stub_request(:get, "https://www.youtube.com/c/unknown-name").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    "Name is unrecognized",
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/c/unknown-name')
    assert_raises Yt::NoItemsError do
      yturl.id
    end
  end
  #    Username form url
  def test_yturl_id_returns_the_YT_resouce_id_given_a_username_form_url_c_user_name
    stub_request(:get, "https://www.youtube.com/user/ogeeku").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    %Q[<meta itemprop="channelId" content="UC4nG_NxJniKoB-n6TLT2yaw">],
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/user/ogeeku')
    assert_equal 'UC4nG_NxJniKoB-n6TLT2yaw', yturl.id
  end

  def test_yturl_id_raises_YT_NoItemsError_given_a_username_form_url_c_unrecognized_user_name
    stub_request(:get, "https://www.youtube.com/user/unknown-name").
      with(headers: WEBMOCK_HEADERS).
      to_return( status:  200,
                 body:    "Name is unrecognized",
                 headers: {})

    yturl = Yt::URL.new('https://www.youtube.com/user/unknown-name')
    assert_raises Yt::NoItemsError do
      yturl.id
    end
  end
  #    Video form url
  def test_yturl_id_returns_the_YT_resouce_id_given_a_video_form_url_c_video_id
    yturl = Yt::URL.new('https://www.youtube.com/watch?v=gknzFj_0vvY')
    assert_equal 'gknzFj_0vvY', yturl.id
  end
  #    Playlist form url
  def test_yturl_id_returns_the_YT_resouce_id_given_a_playlist_form_url_c_playlist_id
    yturl = Yt::URL.new('https://www.youtube.com/playlist?list=LLxO1tY8h1AhOz0T4ENwmpow')
    assert_equal 'LLxO1tY8h1AhOz0T4ENwmpow', yturl.id
  end

  # Resource
  #  Note: Webmock does not yet handle JSON in the body.
  #        Thus cannot mock a response that provides the resource title, etc.
  #        This is probably not required to validate yt-url internals.
  #        However, at some point should validate yt-url's understanding of YouTube API.
  #    Channel
  def test_yturl_resource_returns_a_Yt_Channel_given_a_channel_url_c_an_existing_id
    yturl = Yt::URL.new('https://www.youtube.com/channel/UCxO1tY8h1AhOz0T4ENwmpow')
    assert_equal Yt::Channel, yturl.resource.class
    # ToDo: refute yturl.resource.title.empty?
  end
  #    Video
  def test_yturl_resource_raises_Yt_NoItemsError_given_a_video_url_c_an_invalid_id
    yturl = Yt::URL.new('https://www.youtu.be/tooshort')
    assert_raises Yt::NoItemsError do
      yturl.resource
    end
  end

  def test_yturl_resource_returns_a_Yt_Video_given_a_video_url_c_an_existing_id
    yturl = Yt::URL.new('https://www.youtube.com/watch?v=gknzFj_0vvY')
    assert_equal Yt::Video, yturl.resource.class
    # ToDo: refute yturl.resource.title.empty?
  end

  def test_yturl_resource_returns_a_Yt_Video_given_a_video_url_c_an_unknown_id
    yturl = Yt::URL.new('https://www.youtu.be/unknown-id-')
    assert_equal Yt::Video, yturl.resource.class
    # ToDo: assert_raises Yt::NoItemsError do
    #         yturl.resource.title
    #       end
  end
  #    Playlist
  def test_yturl_resource_returns_a_Yt_Playlist_given_a_playlist_url_c_an_existing_id
    yturl = Yt::URL.new('https://www.youtube.com/playlist?list=PL-LeTutc9GRKD3yBDhnRF_yE8UTaQI5Jf')
    assert_equal Yt::Playlist, yturl.resource.class
    # ToDo: refute yturl.resource.title.empty?
  end

  def test_yturl_resource_returns_a_Yt_Playlist_given_a_playlist_url_c_an_unknown_id
    yturl = Yt::URL.new('https://www.youtube.com/playlist?list=unknown-id')
    assert_equal Yt::Playlist, yturl.resource.class
    # ToDo: assert_raises Yt::NoItemsError do
    #         yturl.resource.title
    #       end
  end
  #    Unknown text
  def test_a_yturl_raises_Yt_NoItemsError_given_an_unknown_text
    yturl = Yt::URL.new('not-really-anything---')
    assert_raises Yt::NoItemsError do
      yturl.resource
    end
  end
end
