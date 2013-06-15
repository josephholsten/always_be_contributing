require 'always_be_contributing/core_ext/date/month_calculator'
require 'always_be_contributing/org'
require 'octokit'

module AlwaysBeContributing
  class CLI
    attr_accessor :github_org
    attr_accessor :date_range

    def initialize(args)
      @github_org = args[0]
      @date_range = parse_date_range(args[1])
      Octokit.netrc = true
    end

    def run
      exit_usage unless github_org
      render
    end

    private
    def default_date_range
      Date.today.beginning_of_month .. (Date.today + 1)
    end

    # 2012-01-01 - contributions since given date
    # 2012-01-01...2013-01-01 - contributions between, excluding end
    # 2012-01-01..2013-01-01 - contributions between, including end
    def parse_date_range(range_str)
      return default_date_range unless range_str
      iso8601_date = '[0-9]{4}-[0-9]{2}-[0-9]{2}'
      patt = /\A(?:(#{iso8601_date})\.\.(\.)?)?(#{iso8601_date})\z/
      patt = /\A(#{iso8601_date})(?:\.\.(\.)?(#{iso8601_date}))?\z/
      whole, start_str, exclude_end, finish_str = patt.match(range_str).to_a
      whole || raise("Couldn't parse date range argument #{range_str}")

      start = start_str && Date.strptime(start_str)
      start ||= default_date_range.begin

      finish = finish_str && Date.strptime(finish_str)
      finish ||= default_date_range.end

      Range.new(start, finish, exclude_end)
    end

    def member_contribution_counts
      @member_contribution_counts ||= begin
        Org.new(github_org).
        member_contribution_count(date_range)
      end
    end

    def render
      puts '=== Contributions ===',
           "github-org: #{github_org}",
           "date range: #{date_range}",
           '---------------------'
      member_contribution_counts.each {|u| puts "%15s %3i" % u }
    end

    def exit_usage
      $stderr.puts "usage: #{$PROGRAM_NAME} github-org [date-range]",
                   '  date-range (optional, default to 1st of current month)',
                   '    YYYY-MM-DD - since the given date',
                   '    YYYY-MM-DD..YYYY-MM-DD - inclusive-end range',
                   '    YYYY-MM-DD...YYYY-MM-DD - exclusive-end range'
      exit 1
    end
  end
end
