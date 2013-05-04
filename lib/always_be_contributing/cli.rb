require 'always_be_contributing/core_ext/date/month_calculator'
require 'always_be_contributing/org'
require 'octokit'

module AlwaysBeContributing
  class CLI
    attr_accessor :github_org

    def initialize(args)
      @github_org = args[0]
      Octokit.netrc = true
    end

    def run
      exit_usage unless github_org
      render
    end

    private
    def begin_date
      Date.today.beginning_of_month
    end

    def member_contribution_counts
      @member_contribution_counts ||= begin
        Org.new(github_org).
        member_contribution_count_since(begin_date)
      end
    end

    def render
      puts "=== Contributions for members of github-org: #{github_org} since: #{begin_date} ==="
      member_contribution_counts.each {|u| puts "%15s %3i" % u }
    end

    def exit_usage
      $stderr.puts "usage: #{$0} github-org"
      exit 1
    end
  end
end
