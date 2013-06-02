require 'json'
require 'open-uri'
require 'uri'

require 'always_be_contributing/contribution'

module AlwaysBeContributing
  class User < Struct.new(:name)
    # return a list of all Contributions available for this user
    def contributions
      doc = contribution_url.read
      JSON.parse(doc).map do |cont|
        Contribution.from_raw(cont)
      end
    end

    # return a list of all Contributions since start_date
    def contributions_since(start_date)
      contributions.select do |c|
        c.date >= start_date
      end
    end

    # return the sum of the values for all Contributions since start_date
    def contribution_count_since(start_date)
      @contribution_count_since ||= {}
      @contribution_count_since[start_date] ||= begin
        contributions_since(start_date).map(&:value).reduce(&:+)
      end
    end

    private
    def contribution_url
      URI.parse "https://github.com/users/#{name}/contributions_calendar_data"
    end
  end
end
