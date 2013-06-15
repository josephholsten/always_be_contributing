#!/usr/bin/env ruby -w
# test_cli.rb: verify AlwaysBeContributing::CLI works as designed

require 'pathname'

# add lib to loadpath
lib_path = Pathname.new(__FILE__).join('../../lib').expand_path
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include? lib_path

require 'minitest/autorun'
require 'minitest/benchmark'
require 'mocha/setup'

require 'always_be_contributing/org'

class TestOrg < Minitest::Test
  def test_name
    org = AlwaysBeContributing::Org.new("foo")
    assert_equal "foo", org.name
  end

  def test_empty_members
    org = AlwaysBeContributing::Org.new("foo")
    Octokit.expects(:org_members).returns([])

    members = org.members

    assert_equal [], members
  end

  def test_members
    org = AlwaysBeContributing::Org.new("foo")
    org_members = [stub(login: 'bob'), stub(login: 'alice')]
    Octokit.expects(:org_members).returns(org_members)

    members = org.members

    expected = [
      AlwaysBeContributing::User.new('bob'),
      AlwaysBeContributing::User.new('alice'),
    ]
    assert_equal expected, members
  end

  def test_empty_member_contribution_count_since
    org = AlwaysBeContributing::Org.new("foo")
    Octokit.expects(:org_members).returns([])

    contrib_counts = org.member_contribution_count_since(Date.today)

    assert_equal [], contrib_counts
  end

  def test_empty_member_contribution_count_since
    org = AlwaysBeContributing::Org.new("foo")
    org_members = [stub(login: 'bob'), stub(login: 'alice')]
    Octokit.expects(:org_members).returns(org_members)
    AlwaysBeContributing::User.expects(:new).with('bob').
      returns(stub(name: 'bob', contribution_count: 3))
    AlwaysBeContributing::User.expects(:new).with('alice').
      returns(stub(name: 'alice', contribution_count: 4))

    contrib_counts = org.member_contribution_count_since(Date.today)

    expected = [
      ["alice", 4],
      ["bob", 3],
    ]
    assert_equal expected, contrib_counts
  end
end
