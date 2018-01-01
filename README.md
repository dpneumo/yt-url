Yt::URL - a URL extension for the Yt library
============================================

My intent for this fork
=======================
Having seen Fullscreen's talk at Ruby Conf 2017 I checked out his Github repos. I found yt-url very interesting. I thought it ought to be possible to use it as the basis for an exercise in refactoring to more closely follow some of the ideas laid out in Sandi Metz' book, POODR. This is the result of that work. I believe it is a true refactoring. That is, the interfaces to the application are not changed. It should be a drop in replacement.

I have used WebMock to avoid having to hit the You Tube API repeatedly during testing. There are some issues associated with WebMock's handling of JSON in the response body ( It can't as yet. ;-{ ). I do not think that impairs the testing of the application under the assumption that the You Tube API is correctly "understood" by yt-url. I think that should be tested but not with every run of tests during development and maintenance/enhancement. Since the You Tube API does not change frequently, it should be enough to test against that actual API rather than against a mock infrequently. Perhaps daily or weekly.

I used minitest rather than rspec. Just a personal preference. I find I have to "think harder" when writing rspec tests. About the syntax and self, not about the testing strategies. The minitest suite is built to closely mirror the rspec tests in the Fullscreen/yt-url version. I think the tests could, in fact, be significantly trimmed as a consequence of the refactoring and the use of WebMock.

I hope this will be useful to others.


Yt::URL helps you identify YouTube resources from their URL.

The **source code** is available on [GitHub](https://github.com/fullscreen/yt-url) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/yt-url/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/yt-url/master.svg)](https://travis-ci.org/Fullscreen/yt-url)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/yt-url/master.svg)](https://coveralls.io/r/Fullscreen/yt-url)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/yt-url.svg)](https://gemnasium.com/Fullscreen/yt-url)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/yt-url.svg)](https://codeclimate.com/github/Fullscreen/yt-url)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/yt-url/frames)
[![Gem Version](http://img.shields.io/gem/v/yt-url.svg)](http://rubygems.org/gems/yt-url)

After [registering your app](https://fullscreen.github.io/yt-core/), you can run commands like:

```ruby
url = Yt::URL.new "youtu.be/gknzFj_0vvY"
url.kind # => :video
url.id # => "gknzFj_0vvY"
url.resource # => #<Yt::Video @id=gknzFj_0vvY>
```

The **full documentation** is available at [rubydoc.info](http://www.rubydoc.info/gems/yt-url/frames).


A comprehensive guide to Yt
===========================

All the classes and methods available are detailed on the [Yt homepage](https://fullscreen.github.io/yt-core/):

[![Yt homepage](https://cloud.githubusercontent.com/assets/10076/19788369/b61d7756-9c5c-11e6-8bd8-05f8d67aef4e.png)](https://fullscreen.github.io/yt-core/)

Please proceed to [https://fullscreen.github.io/yt-core/urls.html](https://fullscreen.github.io/yt-core/urls.html) for more details and examples.


How to install
==============

To install on your system, run

    gem install yt-url

To use inside a bundled Ruby project, add this line to the Gemfile:

    gem 'yt-url', '~> 1.0'

Since the gem follows [Semantic Versioning](http://semver.org),
indicating the full version in your Gemfile (~> *major*.*minor*.*patch*)
guarantees that your project won’t occur in any error when you `bundle update`
and a new version of Yt is released.

How to test
===========

To run live-tests against the YouTube API, type:

```bash
rspec
```

This will fail unless you have set up a test YouTube application and some
tests YouTube accounts to hit the API. If you cannot run tests locally, you
can open PR against the repo and Travis CI will run the tests for you.

These are the environment variables required to run the tests in `spec/requests/server`:

- `YT_SERVER_API_KEY`: API Key of a Google app with access to the YouTube Data API v3 and the YouTube Analytics API

No environment variables are required to run the other tests.

How to release new versions
===========================

If you are a manager of this project, remember to upgrade the [Yt gem](http://rubygems.org/gems/yt-url)
whenever a new feature is added or a bug gets fixed.

Make sure all the tests are passing on [Travis CI](https://travis-ci.org/fullscreen/yt-url),
document the changes in HISTORY.md and README.md, bump the version, then run

    rake release

Remember that the yt gem follows [Semantic Versioning](http://semver.org).
Any new release that is fully backward-compatible should bump the *patch* version (0.0.x).
Any new version that breaks compatibility should bump the *minor* version (0.x.0)

How to contribute
=================

Contribute to the code by forking the project, adding the missing code,
writing the appropriate tests and submitting a pull request.

In order for a PR to be approved, all the tests need to pass and all the public
methods need to be documented and listed in the guides. Remember:

- to run all tests locally: `bundle exec rspec`
- to generate the docs locally: `bundle exec yard`
- to list undocumented methods: `bundle exec yard stats --no-doc`
