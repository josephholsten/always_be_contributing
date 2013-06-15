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

  def test_date
    cli = AlwaysBeContributing::CLI.new(["foo", '2013-01-01'])
    assert_equal Date.new(2013, 1, 1), cli.date_range.begin
    assert_equal Date.today+1, cli.date_range.end
    assert_equal false, cli.date_range.exclude_end?
  end

  def test_date_range
    cli = AlwaysBeContributing::CLI.new(["foo", '2013-01-01..2013-01-31'])
    assert_equal Date.new(2013, 1, 1), cli.date_range.begin
    assert_equal Date.new(2013, 1, 31), cli.date_range.end
    assert_equal false, cli.date_range.exclude_end?
  end

  def test_date_range_exclude_end
    cli = AlwaysBeContributing::CLI.new(["foo", '2013-01-01...2013-02-01'])
    assert_equal Date.new(2013, 1, 1), cli.date_range.begin
    assert_equal Date.new(2013, 2, 1), cli.date_range.end
    assert_equal true, cli.date_range.exclude_end?
  end
end
