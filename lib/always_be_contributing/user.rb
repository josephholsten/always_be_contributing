require 'json'
require 'open-uri'
require 'uri'

require 'always_be_contributing/contribution'

module AlwaysBeContributing
  class User < Struct.new(:name)
    # return a list of all Contributions available for this user
    def contributions
      @contributions ||= begin
        doc = contribution_url.read
        JSON.parse(doc).map do |cont|
          Contribution.from_raw(cont)
        end
      end
    end

    # return a list of all Contributions since start_date
    def contributions_since(start_date)
      tomorrow = Date.today + 1 # yay timezones
      contributions_between(start_date...tomorrow)
    end

    def contributions_between(range)
      contributions.select do |c|
        range.cover? c.date
      end
    end

    # return the sum of the values for all Contributions since start_date
    def contribution_count_since(start_date)
      contributions_since(start_date).map(&:value).reduce(&:+)
    end

    def contribution_count(date_range)
      contributions_between(date_range).map(&:value).reduce(&:+)
    end

    private
    def contribution_url
      URI.parse "https://github.com/users/#{name}/contributions_calendar_data"
    end
  end
end
