require_relative 'test_helper'
require_relative '../lib/yt/parser'

class ParserTest < MiniTest::Test
  def setup
    @video_texts    = [ 'youtube.com/watch?v=abcd-123456',
                        'youtube.com/embed/efgh-123456',
                        'youtube.com/v/ijkl-123456',
                        'youtu.be/mnop-123456', ]
    @playlist_texts = [ 'www.youtube.com/playlist?list=PLEC422D53B75888DC7', ]
    @channel_texts  = [ 'www.youtube.com/channel/UCrDkAvwZum-UTjHmzDl2ilw',
                        'www.youtube.com/officialpsy',
                        'youtube.com/c/qrst-123456',
                        'youtube.com/user/qrst-123456',]
    @bad_url_texts  = [ 'youtube.bad/abcd', ]
    @ytp = Yt::Parser.new
  end

  def test_identifies_a_bad_yt_url
    expected = [{kind: :unknown}]
    assert_equal expected, @bad_url_texts.map {|txt| @ytp.parse txt}
  end

  def test_identifies_channel_urls
    expected = [ {'id' => 'UCrDkAvwZum-UTjHmzDl2ilw', kind: :channel},
                 {'format' => nil, 'name' => 'officialpsy', kind: :channel},
                 {'format' => 'c/', 'name' => 'qrst-123456', kind: :channel},
                 {'format' => 'user/', 'name' => 'qrst-123456', kind: :channel},
               ]
    assert_equal expected, @channel_texts.map {|txt| @ytp.parse txt}
  end

  def test_identifies_playlist_urls
    expected = [ {'id' => 'PLEC422D53B75888DC7', kind: :playlist} ]
    assert_equal expected, @playlist_texts.map {|txt| @ytp.parse txt}
  end

  def test_identifies_video_urls
    expected = [ {'id' => 'abcd-123456', kind: :video},
                 {'id' => 'efgh-123456', kind: :video},
                 {'id' => 'ijkl-123456', kind: :video},
                 {'id' => 'mnop-123456', kind: :video},
               ]
    assert_equal expected, @video_texts.map {|txt| @ytp.parse txt}
  end
end
