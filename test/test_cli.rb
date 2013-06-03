#!/usr/bin/env ruby -w
# test_cli.rb: verify AlwaysBeContributing::CLI works as designed

require 'pathname'

# add lib to loadpath
lib_path = Pathname.new(__FILE__).join('../../lib').expand_path
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include? lib_path

require 'minitest/autorun'
require 'minitest/benchmark'

require 'always_be_contributing/cli'

class TestCLI < Minitest::Test
  def test_github_org
    cli = AlwaysBeContributing::CLI.new(["foo"])
    assert_equal "foo", cli.github_org
  end
end
